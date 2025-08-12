-- Check record counts match expectations
SELECT 'customers' as table_name, COUNT(*) FROM customers
UNION ALL
SELECT 'products', COUNT(*) FROM products;

-- Check for data integrity
SELECT 'Orders with missing customers' as check_type, 
       COUNT(*) as issue_count
FROM orders o 
LEFT JOIN customers c ON o.customer_id = c.customer_id 
WHERE c.customer_id IS NULL;

-- Check date ranges
SELECT 'Date range check' as check_type,
       MIN(order_date) as earliest_order,
       MAX(order_date) as latest_order
FROM orders;