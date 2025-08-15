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



--set assignment date (real world use: CURRENT_DATE() directly)
WITH set_date AS (
    SELECT '2024-07-31'::DATE as analysis_date
),


--1. Calculate raw R, F, M for each customer
rfm_data AS (
    SELECT 
        o.customer_id,
        SUM(o.total_amount) AS total_amount_spent,
        COUNT(o.order_id) AS number_of_orders,
        MAX(order_date) AS last_purchase_date,
       EXTRACT(days FROM AGE(sd.analysis_date, MAX(o.order_date))) AS recency_days
    FROM orders o
    CROSS JOIN set_date sd
    GROUP BY o.customer_id, sd.analysis_date
)

SELECT * FROM rfm_data;


--2. Apply NTILE() scoring to each dimension



--3. Create segment assignment rules using CASE statements

/*   Business Segments:

Champions: High in all three (R=5, F=5, M=5)
Loyal Customers: High frequency and monetary, varying recency
At Risk: Low recency, historically good customers
New Customers: High recency, low frequency
Lost Customers: Low in all dimensions */


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

