--Exploration is run first to confirm table names, column types, and row counts before any transformation logic is written.
--INFORMATION_SCHEMA is queried rather than assuming column names, so silver and gold are built against the real schema.
--The test JOIN is run here to prove the order_id join and the delivered filter on raw data before aggregation is added downstream.
SELECT TOP 10 *
    FROM olist_orders_dataset

SELECT COLUMN_NAME,DATA_TYPE, IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'olist_orders_dataset'
ORDER BY ORDINAL_POSITION


-- Row counts across all tables
SELECT 'olist_orders_dataset' AS table_name, COUNT(*) AS row_count FROM olist_orders_dataset
UNION ALL
SELECT 'olist_customers_dataset', COUNT(*) FROM olist_customers_dataset
UNION ALL
SELECT 'olist_order_items_dataset', COUNT(*) FROM olist_order_items_dataset
UNION ALL
SELECT 'olist_order_payments_dataset', COUNT(*) FROM olist_order_payments_dataset
UNION ALL
SELECT 'olist_order_reviews_dataset', COUNT(*) FROM olist_order_reviews_dataset
UNION ALL
SELECT 'olist_products_dataset', COUNT(*) FROM olist_products_dataset
UNION ALL
SELECT 'olist_sellers_dataset', COUNT(*) FROM olist_sellers_dataset
UNION ALL
SELECT 'olist_geolocation_dataset', COUNT(*) FROM olist_geolocation_dataset
UNION ALL
SELECT 'product_category_name_translation', COUNT(*) FROM product_category_name_translation


-- Test JOIN between orders and order items (delivered orders only)
-- Confirms join condition on order_id works before adding aggregation
SELECT *
FROM olist_orders_dataset
JOIN olist_order_items_dataset
ON olist_orders_dataset.order_id = olist_order_items_dataset.order_id
WHERE olist_orders_dataset.order_status = 'delivered'










