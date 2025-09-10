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
   POTENTIAL ADD ONS:
    --Retention Rate by Segment (30, 60, 90 day)
    --Growth Potential Score (combination of purchase frequency trend, spending growth, category expansion)
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



-- ================================================================================= --
-- QUESTION 2: Customer Cohort Analysis                                              --
-- Address:How are customers retained over time, and which acquisition periods had   --
-- best retention                                                                    --
-- ================================================================================= --
/*************************************************************************************
 IN PROGRESS Notes: 
 registration date is NOT the "first" order date 
 Need to fix date comparisons in order to account for that
**************************************************************************************/

--RAW DATA 

--1. table with registration month and order months for customers
-- Calculate months between registration and purchases
WITH customer_order_data AS( 
    SELECT DISTINCT
        c.customer_id, 
        DATE_TRUNC('month', c.registration_date) AS registration_month,
        DATE_TRUNC('month', o.order_date) AS order_month,
        EXTRACT(month FROM AGE(
        DATE_TRUNC('month', o.order_date), 
        DATE_TRUNC('month', c.registration_date)
        )) AS months_since_reg    
    FROM customers c
    LEFT JOIN orders o ON c.customer_id = o.customer_id
    ORDER BY c.customer_id
)


--FOR TESTING (REMOVE)
SELECT * FROM customer_order_data;
/*
SELECT 
    TO_CHAR(registration_month, 'MON YYYY') AS cohort,
    COUNT(customer_id) AS num_customers
FROM customer_order_data
GROUP BY registration_month
ORDER BY registration_month ASC;
*/


--ANALYTICAL DATA 


--2. Monthly cohort retention rates 
cohort_retention AS (
    TO_CHAR(registration_month,'MON YYYY') AS cohort_month,
    COUNT(customer_id) AS cohort_size, 
    --EXTRACT(month FROM AGE(registration_month,order_month)) AS months_since_registration (NOTE: trying to avoid calculating here, because of GROUP BY)
    CASE                                                       
        WHEN months_since_registration = 0 THEN 'Month 0'
        WHEN months_since_registration = 1 THEN 'Month 1'
        WHEN months_since_registration >= 2 AND months_since_registration <=3 THEN 'Month 2-3'
        WHEN months_since_registration >= 4 AND months_since_registration <= 6 THEN 'Month 4-6'
        WHEN months_since_registration >= 7 AND <= 12 THEN 'Month 7-12'
        ELSE "12 Month +"
    END AS retention_period,

    
-- Count customers active in specific periods
--COUNT(CASE WHEN [condition] THEN customer_id END)
        --rows: percent of cohort active in that period (starts at 100)
    FROM customer_order_data
    GROUP BY cd.registration_month
    ORDER BY cd.registration_month ASC
)




--2.Cohort performance comparison 

customer_cohort_performance AS(
    SELECT 
        TO_CHAR(cd.registration_month,'MON YYYY') AS cohort_month,
        SUM(o.total_amount) AS total_revenue,
        ROUND(AVG(o.total_amount),2) AS avg_revenue   --Revenue per Cohort - total and average revenue generated
        --Order Frequency - how often cohort members purchase
        --Average Order Value - spending patterns over time  AOV = total revenue / sum order quantity
            --SUM(o.total_amount) / SUM(oi.quantity) --NOTE: to get quantity from order_items need order_id 
    FROM customer_order_data cd
    LEFT JOIN orders o ON cd.customer_id = o.customer_id
    GROUP BY cd.registration_month
    ORDER BY cd.registration_month ASC
)


--for testing (remove later)
--SELECT * FROM customer_cohort_performance;
 


--PRESENTATION LAYER

--3.Retention trends and patterns identification 


--customers with orders prior to their registration date
SELECT c.customer_id, c.registration_date, MIN(o.order_date) as first_order
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.registration_date
HAVING MIN(o.order_date) < c.registration_date;

--customers with no orders
SELECT COUNT(*) as null_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_date IS NULL;








-- ================================================================================= --
-- QUESTION 3: Customer Lifetime Value Modeling                                      --
-- Address:What is the predicted lifetime value of different customer segments?      --
-- ================================================================================= --

