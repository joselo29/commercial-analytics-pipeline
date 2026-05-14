
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