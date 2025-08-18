-- =====================================================================================================================
-- PART 2 : ADVANCED CUSTOMER SEGMENTATION
-- Purpose: Use advanced customer analytics to identify high-value segments, udnerstand retention patterns and optimize
-- marketing spend allocation
-- Note: Assignment pseudo date "July 31, 2024"
-- Analyst: Samantha Riesterer
-- ====================================================================================================================

-- ================================================================================= --
-- QUESTION 1: RFM Analysis                                                          --
-- Address:How should we segmenet our customers for targeted campaigns?              --         
-- ================================================================================= --

/*******************************************************************************************************************
   Notes: 
   Multi-dimensional logic for segment assignment
   Business rules based on score combinations
********************************************************************************************************************/


--set assignment date (real world use: CURRENT_DATE())
WITH set_date AS (
    SELECT '2024-07-31'::DATE as analysis_date
),


--1. Calculate raw R, F, M for each customer
rfm_data AS (
    SELECT 
        o.customer_id,
        SUM(o.total_amount) AS total_amount_spent, --monetary
        COUNT(o.order_id) AS number_of_orders, --frequency
        MAX(order_date) AS last_purchase_date,
       EXTRACT(days FROM AGE(sd.analysis_date, MAX(o.order_date))) AS recency_days --recency
    FROM orders o
    CROSS JOIN set_date sd
    GROUP BY o.customer_id, sd.analysis_date
),

--2.Calculate score for each dimension for each customer using NTILE()
rfm_score_customers AS (

    SELECT 
        customer_id,
        total_amount_spent,
        number_of_orders,
        recency_days,
        NTILE(5) OVER (ORDER BY recency_days DESC) AS recency_score,
        NTILE(5) OVER (ORDER BY number_of_orders ASC) AS frequency_score,
        NTILE(5) OVER (ORDER BY total_amount_spent ASC) AS monetary_score
    FROM rfm_data
),

--3. Assign customers to a segment using CASE statements

customer_segment AS (
    SELECT 
        customer_id,
        CASE
            WHEN recency_score >= 4 AND frequency_score >= 4 AND monetary_score >= 4 THEN 'CHAMPIONS'
            WHEN recency_score >= 4 AND frequency_score <= 2  THEN 'NEW CUSTOMERS'
            WHEN recency_score <= 2 AND frequency_score <= 2 THEN 'LOST CUSTOMERS'
            WHEN recency_score <=2 AND frequency_score >= 4 AND monetary_score >= 3 THEN 'AT RISK'
            WHEN monetary_score >= 3 AND frequency_score >= 3 THEN 'LOYALISTS'       -- lower requirements as tech customers don't make as frequent purchases
            WHEN monetary_score >=2 AND frequency_score >= 2 THEN 'POTENTIAL LOYALISTS'
            ELSE 'MIXED BEHAVIOR' 
        END AS segment
    FROM rfm_score_customers
),


--4. Group customers by segment and aggregate segment characteristics

segment_data AS (
    SELECT 
        cs.segment,
        COUNT(cs.customer_id) AS segment_size,
        SUM(rfm.total_amount_spent) AS segment_clv,
        ROUND(AVG(rfm.recency_days),0) AS avg_recency,
        ROUND(AVG(rfm.number_of_orders),0) AS avg_frequency,
        ROUND(AVG(rfm.total_amount_spent),2) AS avg_monetary
    FROM customer_segment cs
    JOIN  rfm_score_customers rfm ON rfm.customer_id = cs.customer_id
    GROUP BY segment
)

--5. Final output with business metrics
SELECT 
    *,
   ROUND(segment_clv / SUM(segment_clv) OVER() * 100,2) || '%' AS revenue_contribution --segment % of total revenue
FROM segment_data;

--Retention Rate by Segment (30, 60, 90 day)
--Growth Potential Score (combination of purchase frequency trend, spending growth, category expansion)


-- ================================================================================= --
-- QUESTION 2: Customer Cohort Analysis                                              --
-- Address:How are customers retained over time, and which acquisition periods had   --
-- best retention                                                                    --
-- ================================================================================= --
/*Notes: 
 Self-JOINs for cohort analysis
 Advanced date calculations
 Cross-tabulation techniques

--  
*/

--1. Monthly cohort retention rates 
    --cohort table with registration month and order months
WITH customer_cohort AS( 
    SELECT 
        c.customer_id, 
        DATE_TRUNC('month', c.registration_date) AS registration_month,
       DATE_TRUNC('month', o.order_date) AS order_month,
        DATE_TRUNC('month',LAG(o.order_date) OVER (PARTITION BY c.customer_id ORDER BY o.order_date)) AS prev_order_month
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
)
SELECT * FROM customer_cohort;
     
     
     --calc retention rates




--2.Cohort performance comparison 
    --Revenue per Cohort - total and average revenue generated
    --Order Frequency - how often cohort members purchase
    --Average Order Value - spending patterns over time

--3.Retention trends and patterns identification 
    --Retention Rate - % of cohort still active in each period




-- Calculate months between registration and purchase
--DATE_PART('month', AGE(order_date, registration_date))
-- Or use EXTRACT for month differences


-- Count customers active in specific periods
--COUNT(CASE WHEN [condition] THEN customer_id END)





-- ================================================================================= --
-- QUESTION 3: Customer Lifetime Value Modeling                                      --
-- Address:What is the predicted lifetime value of different customer segments?      --
-- ================================================================================= --

