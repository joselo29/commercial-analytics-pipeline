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