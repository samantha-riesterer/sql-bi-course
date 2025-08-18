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
        ROUND(AVG(rfm.recency_days),0) AS avg_recency,
        ROUND(AVG(rfm.number_of_orders),0) AS avg_frequency,
        ROUND(AVG(rfm.total_amount_spent),2) AS avg_monetary
    FROM customer_segment cs
    JOIN  rfm_score_customers rfm ON rfm.customer_id = cs.customer_id
    GROUP BY segment
)


SELECT * FROM segment_data;

--revenue contribution % of total revenue 
--clv per segment 
--retention rate indicators ??
--growth potential

--ROUND at end
/*

*/

-- ================================================================================= --
-- QUESTION 2: Customer Cohort Analysis                                              --
-- Address:How are customers retained over time, and which acquisition periods had   --
-- best retention                                                                    --
-- ================================================================================= --
/*-- LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) */

-- ================================================================================= --
-- QUESTION 3: Customer Lifetime Value Modeling                                      --
-- Address:What is the predicted lifetime value of different customer segments?      --
-- ================================================================================= --

