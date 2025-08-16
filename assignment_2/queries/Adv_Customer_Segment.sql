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
   Instead of simple averages, consider weighted combinations or priority rules for segment assignment.

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

--2. Apply NTILE() scoring to each dimension
rfm_score_customers AS (

    SELECT 
        customer_id,
        NTILE(5) OVER (ORDER BY recency_days DESC) AS recency_score,
        NTILE(5) OVER (ORDER BY number_of_orders ASC) AS frequency_score,
        NTILE(5) OVER (ORDER BY total_amount_spent ASC) AS monetary_score
    FROM rfm_data

),

--3. Create segment assignment rules using CASE statements

customer_segments AS (
    SELECT 
        CASE
            WHEN recency_score >= 4 AND frequency_score >= 4 AND monetary_score >= 4 THEN 'CHAMPIONS'
            WHEN recency_score >= 4 AND frequency_score <= 2  THEN 'NEW CUSTOMERS'
            WHEN recency_score <= 2 AND frequency_score <= 2 THEN 'LOST CUSTOMERS'
            WHEN recency_score <=2 AND frequency_score >= 4 AND monetary_score >= 3 THEN 'AT RISK'
            WHEN monetary_score >= 3 AND frequency_score >= 3 THEN 'LOYALISTS'              --tech customers don't make as frequent purchases
            WHEN monetary_score >=2 AND frequency_score >= 2 THEN 'POTENTIAL LOYALISTS'
            ELSE 'MIXED BEHAVIOR' 
        END AS segments,
        COUNT(customer_id) AS customer_count
    FROM rfm_score_customers
    GROUP BY segments
)

SELECT * FROM customer_segments;

--4. Aggregate segment characteristics





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

