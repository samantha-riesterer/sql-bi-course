
-- ==================================================================================================================
-- PART 2 : CORE BUSINESS ANALYSIS
-- Purpose: Develop data-driven insights into sales performance, customer behavior and product trends 
-- Analyst: Samantha Riesterer
-- ==================================================================================================================



-- ================================================================================= --
-- QUESTION 1: PRODUCT PERFORMANCE ANALYSIS                                          --
-- Purpose: Identify which products and categories drive sales                       --         
-- ================================================================================= --

/*******************************************************************************************************************
    Q 1.1 : Top 5 best-selling products by quantity sold. 
    
    Notes: Include product_name, category, brand, total quantity sold. Sort by quantity (highest first)
********************************************************************************************************************/
SELECT 
    p.product_name, 
    p.category,
    p.brand,
    SUM(oi.quantity) AS total_quantity_sold  --sum quantity from sold orders
     
FROM order_items oi
INNER JOIN products p ON oi.product_id = p.product_id
GROUP BY oi.product_id, product_name, category, brand 
ORDER BY total_quantity_sold DESC   --best selling first
LIMIT 5;   --limit top 5


/******************************************************************************************************************
    Q 1.2 : Top 5 revenue generation products. 
   
    Notes: Include product_name, category, total revenue, average order value. Sort by total revenue (highest first)
    AOV = total revenue / sum order quantity
*******************************************************************************************************************/

SELECT 
    p.product_name, 
    p.category, 
    SUM(oi.total_price) AS total_revenue,
    ROUND(SUM(oi.total_price) / SUM(oi.quantity),2) AS avg_order_value    --AOV
 
FROM order_items oi
INNER JOIN products p ON oi.product_id = p.product_id     
GROUP BY oi.product_id, product_name, category 
ORDER BY total_revenue DESC   --highest revenue first                                            
LIMIT 5;    --limit to top 5


/******************************************************************************************************************
    Q 1.3 : Category performance summary. 
    
    Notes:  Include category, number of products, total revenue, average price. Sort by total revenue (highest first)
*******************************************************************************************************************/

SELECT 
    p.category,
    SUM(oi.total_price) AS total_revenue,
    COUNT(DISTINCT oi.product_id) AS num_products, --number of products
    ROUND(AVG(oi.unit_price),2) AS avg_price --average price
FROM order_items oi
INNER JOIN products p ON oi.product_id = p.product_id     
GROUP BY category 
ORDER BY total_revenue DESC --highest revenue first
LIMIT 5;  --limit to top 5




-- ================================================================================= --
-- QUESTION 2: CUSTOMER ANALYSIS                                                     --
-- Purpose: Understand customer value distribution and geographic concentration      --         
-- ================================================================================= --


/******************************************************************************************************************
    Q 2.1 : Top 10 customers by total spending. 
  
    Notes:Include customer name, email, total spent, number of orders. Sort by total spent (highest first)
*******************************************************************************************************************/
SELECT 
    c.first_name || ' ' || c.last_name AS customer_name,
    c.email, 
    COUNT(DISTINCT o.order_id) AS num_orders,   --count orders
    ROUND(SUM(o.total_amount),0) AS total_spent --sum customer spending
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, customer_name, c.email
ORDER BY total_spent DESC --highest spending first
LIMIT 10; --limit to top 10 

/******************************************************************************************************************
    Q 2.2 : Customer spending distribution
    
    Notes:Create spending tiers and show count of customers in each tier: 
        High value >$1000 
        Medium value $500-$1000 
        Low value <500
*******************************************************************************************************************/

--Retrieve customer info
WITH cstmer_total_spent AS (
    SELECT
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)

SELECT
   --Sort customers into tiers
    CASE 
        WHEN  total_spent > 1000 THEN 'High Value'
        WHEN total_spent < 500 THEN 'Low Value'
        ELSE 'Medium Value'
    END AS spending_tier,

    COUNT(*) AS customer_count  --count customers in each tier
FROM cstmer_total_spent
GROUP BY spending_tier
ORDER BY customer_count ASC;  --for display sorting / tier order


/******************************************************************************************************************
    Q 2.3 : Top 10 states by total revenue (highest first). 
   
    Notes: Include state, number of customers, total revenue, average order value   
*******************************************************************************************************************/

SELECT 
    c.state,
    COUNT(DISTINCT o.customer_id) AS state_customers,  --count customers from each state
    SUM(o.total_amount) AS total_revenue,
    ROUND(SUM(o.total_amount) / SUM(oi.quantity),2) AS avg_order_value  --AOV
    
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id   --join 3 tables to retrieve data
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY c.state 
ORDER BY total_revenue DESC  --highest revenue first
LIMIT 10;  --limit to top 10



-- ====================================================================== --
-- QUESTION 3: SALES TRENDS & TIMING                                      --
-- Purpose: Identify seasonal patterns and operational insights           --         
-- ====================================================================== --

/******************************************************************************************************************
    Q 3.1 : Monthly sales trend, chronologically.
    
    Notes: Including: month, total revenue, # orders, AOV
*******************************************************************************************************************/
SELECT 
    TO_CHAR(DATE_TRUNC('month', o.order_date), 'Month YYYY') AS month_column, --transform dates into month column
    SUM(o.total_amount) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS num_orders,  --count orders in each month
    ROUND(SUM(o.total_amount) / SUM(oi.quantity),2) AS avg_order_value --AOV
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY DATE_TRUNC('month', o.order_date)
ORDER BY DATE_TRUNC('month', o.order_date) ASC;  --sort chronologically



/******************************************************************************************************************
    Q 3.2 : Daily sales patterns, identify best-performing days. 
    
    Notes:Including: day of month, total revenue, # orders
    Best by revenue: ORDER BY total_revenue DESC
    Best by volume: ORDER BY num_orders DESC
*******************************************************************************************************************/

--TOP 10 DAYS BY REVENUE
SELECT 
    EXTRACT(day FROM orders.order_date) AS day_of_month,
    SUM(orders.total_amount) AS total_revenue,
    COUNT(DISTINCT orders.order_id) AS num_orders
FROM orders
GROUP BY day_of_month
ORDER BY total_revenue DESC
LIMIT 10;


--TOP 10 DAYS BY ORDER VOLUME
SELECT 
    EXTRACT(day FROM orders.order_date) AS day_of_month,
    COUNT(DISTINCT orders.order_id) AS num_orders,
    SUM(orders.total_amount) AS total_revenue
FROM orders
GROUP BY day_of_month
ORDER BY num_orders DESC
LIMIT 10;




/******************************************************************************************************************
    Q 3.3 : Recent order status analysis, for orders from July 2024. 
   
    Notes: Including: status, count of orders, total value 
*******************************************************************************************************************/

SELECT 
    status, 
    SUM(total_amount) AS total_value,
    COUNT(DISTINCT orders.order_id) AS num_orders
FROM orders
WHERE order_date >= '2024-07-01' AND order_date < '2024-08-01'  --only select orders from July 2024
GROUP BY status;



-- ====================================================================== --
-- QUESTION 4: PROFIT & PRICING ANALYSIS                                  --
-- Purpose: Understand which products and categories are most profitable  --         
-- ====================================================================== --



/******************************************************************************************************************
    Q 4.1 : Product profitability analysis
   
    Notes:  - show top 10 profit margin. Include: product name, total revenue, total cost, profit margin %
    (revenue - cost) / revenue * 100 = profit margin 
*******************************************************************************************************************/

--Aggregate product profit data
WITH product_profit_data AS ( 
    SELECT 
        p.product_name,
        ROUND(SUM(oi.total_price),2) AS total_revenue,
        ROUND(SUM(p.cost_price * oi.quantity),2) AS total_cost
    FROM products p
    JOIN order_items oi on p.product_id = oi.product_id
    GROUP BY p.product_name
)

--Then calculate profit margin
SELECT  
     *, 
    ROUND((total_revenue - total_cost) / total_revenue * 100, 2) || '%' AS profit_margin 
FROM product_profit_data
ORDER BY profit_margin DESC --show highest first
LIMIT 10; --limit to top 10



/******************************************************************************************************************
    Q 4.2 : Category profitability
  
    Notes:Includencategory, total_revenue, total cost, profit margin %, total profit sort by total profit (DESC). 
*******************************************************************************************************************/
--Aggregate category profit data
WITH category_profit_data AS (
    SELECT  
    p.category, 
    ROUND(SUM(oi.total_price),2) AS total_revenue,
    ROUND(SUM(p.cost_price * oi.quantity),2) AS total_cost
    FROM products p
    JOIN order_items oi on p.product_id = oi.product_id
    GROUP BY p.category
)
--Then calculate profit margin
SELECT
     *, 
    (total_revenue - total_cost) AS total_profit,
    ROUND((total_revenue - total_cost) / total_revenue * 100, 2) || '%' AS profit_margin
FROM category_profit_data --show highest first
ORDER BY total_profit DESC; --limit to top 10


/******************************************************************************************************************
    Q 4.3 : Pricing strategy insights - identify categories with high/low margins.
   
    Notes: Include category, avg. selling price, avg. cost, avg. margin. Sort categories by DESC avg. margins 
*******************************************************************************************************************/
SELECT 
    p.category,
    ROUND(AVG(oi.total_price), 2) AS avg_selling_price,
    ROUND(AVG(p.cost_price), 2) AS avg_cost,
    ROUND(AVG((oi.total_price - p.cost_price) / oi.total_price * 100), 2) || '%' AS avg_margin
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY AVG((oi.total_price - p.cost_price) / oi.total_price * 100) DESC;


-- ==================================================================================================================
-- PART 3 : ADVANCED ANALYSIS
-- Purpose: Investigate how to improve customer retention and increase order values
-- ==================================================================================================================

/******************************************************************************************************************
    Q 1 : Repeat customer analysis - identify customers with multiple orders
    
    Notes:.Include customer info, # orders, total spent,avg days between orders
*******************************************************************************************************************/
WITH customer_order_gaps AS (
    -- Step 1: Calculate gaps between consecutive orders
    SELECT 
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_name,
        c.email,
        o.order_date,
        o.total_amount,
        LAG(o.order_date) OVER (PARTITION BY c.customer_id ORDER BY o.order_date) AS prev_order_date, --given current date row, retrieve previous date row
        EXTRACT(days FROM AGE(o.order_date, LAG(o.order_date) OVER (PARTITION BY c.customer_id ORDER BY o.order_date))) AS days_between --calculate days between
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
),

repeat_customers AS (
    -- Step 2: Aggregate customer-level metrics
    SELECT 
        customer_id,
        customer_name,
        email,
        COUNT(*) AS num_orders,
        SUM(total_amount) AS total_spent,
        AVG(days_between) AS avg_days_between_orders
    FROM customer_order_gaps
    WHERE prev_order_date IS NOT NULL  -- Exclude first orders (no gap to calculate)
    GROUP BY customer_id, customer_name, email
)

-- Step 3: Final filtering and presentation
SELECT 
    customer_id,
    customer_name,
    email,
    num_orders + 1 AS total_orders,  -- +1 to account for excluded first orders
    total_spent,
    ROUND(avg_days_between_orders, 0) AS avg_days_between_orders --round at end for data precision
FROM repeat_customers
WHERE num_orders >= 1  -- Ensures multiple orders (at least 2 total)
ORDER BY total_orders DESC, total_spent DESC;
    



/******************************************************************************************************************
    Q 2.A : Part A Order composition analysis - average number of items per order by category

    Notes: Interpretation: for each category, how many items of that category are bought on average 
*******************************************************************************************************************/

--group category and order_id (JOIN products and order_items info)
--group number of items by order_id and category
WITH order_category_items AS ( 
    SELECT 
        p.category,
        SUM(oi.quantity) AS num_items,
        oi.order_id
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY category,order_id
)

--avg number of items & display
SELECT 
    category,
    ROUND(AVG(num_items),1) AS avg_items_per_order
    FROM order_category_items
    GROUP BY category
    ORDER BY avg_items_per_order DESC;



/******************************************************************************************************************
    Q 2.B :  Part B Order composition analysis - Multi-item vs single-item order patterns

    Notes: Display order_type, order_count, percentage, avg_revenue        
*******************************************************************************************************************/

--Aggregate values for order composition
WITH order_composition AS (
    SELECT
        order_items.order_id,
        SUM(order_items.total_price) AS revenue,
        SUM(order_items.quantity) AS total_items
        FROM order_items 
        GROUP BY order_id
)

--Sort orders into single vs multi item & count entries
--Calculate average revenue & percentage share of each type
SELECT
    CASE 
        WHEN total_items = 1 THEN 'Single-Item'
        ELSE 'Multi-Item'
    END AS order_type,

    COUNT(*) AS order_count,
    ROUND(AVG(revenue),2) AS avg_revenue,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) || '%' AS percentage
    FROM order_composition
    GROUP BY order_type
    ORDER BY order_count DESC;

  


/******************************************************************************************************************
    Q 3.A : Part A Customer acquisition timeline - monthly new customer registrations 
    
    Notes: "Group customers by the month they registered, then count how many per month."
*******************************************************************************************************************/


SELECT 
    TO_CHAR(DATE_TRUNC('month', registration_date), 'Month YYYY') AS registration_month,
    COUNT(customer_id) AS new_customer_registrations
FROM customers
GROUP BY DATE_TRUNC('month', registration_date)  -- Group by the unformatted date
ORDER BY DATE_TRUNC('month', registration_date) ASC;  -- Order by the unformatted date, chronologically



/******************************************************************************************************************
    Q 3.B : Part B Customer acquisition timeline - customer lifetime value for different registration periods
    
    Notes:Calculate the total spending/revenue from customers, grouped by when they registered
    CLV = Total revenue generated by a customer during their relationship with the company.
*******************************************************************************************************************/

--Calculate total spending per customer (individual CLV)
--SUM() total spending per customer
WITH customer_spending AS (
    SELECT
        c.customer_id,
        SUM(o.total_amount) AS customer_spending_total,
        c.registration_date
    FROM customers c
    JOIN orders o ON o.customer_id = c.customer_id
    GROUP BY c.customer_id, c.registration_date
)

--Average the CLV within each period 
--COUNT() customers per period
--Group customers by registration period

SELECT
    TO_CHAR(DATE_TRUNC('quarter', registration_date), 'YYYY') || 
    ' Q' || TO_CHAR(DATE_TRUNC('quarter', registration_date), 'Q') AS registration_period,
    COUNT(customer_id) AS num_customers,
    ROUND(AVG(customer_spending_total),2) AS avg_clv
    FROM customer_spending
    GROUP BY DATE_TRUNC('quarter', registration_date) 
    ORDER BY DATE_TRUNC('quarter', registration_date);





