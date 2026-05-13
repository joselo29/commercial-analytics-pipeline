SELECT TOP 10 *
    FROM dbo.olist_orders_dataset

SELECT COLUMN_NAME,DATA_TYPE, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'olist_orders_dataset'
ORDER BY ORDINAL_POSITION


-- Row counts across all tables
SELECT 'olist_orders_dataset' AS table_name, COUNT(*) AS row_count FROM dbo.olist_orders_dataset
UNION ALL
SELECT 'olist_customers_dataset', COUNT(*) FROM dbo.olist_customers_dataset
UNION ALL
SELECT 'olist_order_items_dataset', COUNT(*) FROM dbo.olist_order_items_dataset
UNION ALL
SELECT 'olist_order_payments_dataset', COUNT(*) FROM dbo.olist_order_payments_dataset
UNION ALL
SELECT 'olist_order_reviews_dataset', COUNT(*) FROM dbo.olist_order_reviews_dataset
UNION ALL
SELECT 'olist_products_dataset', COUNT(*) FROM dbo.olist_products_dataset
UNION ALL
SELECT 'olist_sellers_dataset', COUNT(*) FROM dbo.olist_sellers_dataset
UNION ALL
SELECT 'olist_geolocation_dataset', COUNT(*) FROM dbo.olist_geolocation_dataset
UNION ALL
SELECT 'product_category_name_translation', COUNT(*) FROM dbo.product_category_name_translation


-- Test JOIN between orders and order items (delivered orders only)
-- Confirms join condition on order_id works before adding aggregation
SELECT *
FROM dbo.olist_orders_dataset
JOIN dbo.olist_order_items_dataset
ON dbo.olist_orders_dataset.order_id = dbo.olist_order_items_dataset.order_id
WHERE dbo.olist_orders_dataset.order_status = 'delivered'


-- Business Question 1: Monthly revenue and order volume trend
SELECT
    YEAR(order_purchase_timestamp) AS order_year,
    MONTH(order_purchase_timestamp) AS order_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.price) AS total_revenue
FROM dbo.olist_orders_dataset AS o
JOIN dbo.olist_order_items_dataset AS oi
ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY YEAR(order_purchase_timestamp), MONTH(order_purchase_timestamp)
ORDER BY order_year, order_month


--Business Question 2: Which product categories drive the most revenue?
-- Joins order items, products, and category translation tables
-- Groups by English category name, ordered by total revenue descending

SELECT product_category_name_english, SUM(oi.price) AS total_revenue
FROM olist_order_items_dataset AS oi
INNER JOIN olist_products_dataset AS p
ON oi.product_id = p.product_id
INNER JOIN product_category_name_translation AS pct
ON p.product_category_name = pct.product_category_name
GROUP BY product_category_name_english
order by total_revenue DESC


