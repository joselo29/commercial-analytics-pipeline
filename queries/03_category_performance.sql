-- Gold layer: revenue by product category
-- Business Question 2
--CREATE OR REPLACE TABLE materialises this as a gold aggregate so Power BI reads a ready table instead of recomputing the joins at query time.
--The join to silver_category_translation returns English category names, since the source category column is in Portuguese.
--This builds on silver tables that are already cleaned and filtered to delivered orders, so the delivered filter is not repeated here.
CREATE OR REPLACE TABLE gold_category_performance AS
SELECT
    ct.product_category_name_english,
    SUM(oi.price) AS total_revenue
FROM silver_order_items AS oi
JOIN silver_orders AS o ON oi.order_id = o.order_id
JOIN silver_products AS p ON oi.product_id = p.product_id
JOIN silver_category_translation AS ct ON p.product_category_name = ct.product_category_name
GROUP BY ct.product_category_name_english
ORDER BY total_revenue DESC