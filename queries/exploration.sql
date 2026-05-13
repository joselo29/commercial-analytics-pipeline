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



--Business Question 3: Which sellers have the best and worst delivery performance?
--Join it three different tables:sellers data set,orders item data set, orders dataset
--Calculates average delivery time in days for each seller based on delivered orders
-- Ordered ASC = best performers first, change to DESC for worst performers
SELECT s.seller_id, AVG(DATEDIFF(day, o.order_estimated_delivery_date,o.order_delivered_customer_date)) AS avg_delivery_time
FROM olist_sellers_dataset AS s
JOIN olist_order_items_dataset  AS oi
ON s.seller_id = oi.seller_id
JOIN  dbo.olist_orders_dataset AS o
ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY s.seller_id
ORDER BY avg_delivery_time ASC



--Business Question 4: What is the relationship between delivery delay and customer review score?
-- Joins order reviews with orders to calculate delivery delay for each review
-- Groups by review score to find average delivery delay for each score
SELECT r.review_score, AVG(DATEDIFF(day, o.order_estimated_delivery_date,o.order_delivered_customer_date)) AS delivery_delay
FROM olist_order_reviews_dataset AS r
JOIN dbo.olist_orders_dataset AS o
ON r.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY r.review_score
ORDER BY r.review_score DESC

--Business Question 5: Which 20% of sellers drive 80% of revenue?
--A CTE table was created to capture the total revenue.  And also filter by delivery.
--Then I got the city table, but use it to get first the individual seller ID total revenue. Then I used it, running total, which accumulates. Then I got the grand total, and then I used a cumulative percentage that divides the running total by the grand total.
--Row 532 is at 79.97%. That means that 533 sellers out of 3,095 sellers drive 80% of revenue.
--Calculating 533 divided by 3095 equals 17.2%, closer to the 80/20 rule
WITH SellerRevenue AS(
SELECT oi.seller_id, SUM(oi.price) AS total_revenue
FROM olist_order_items_dataset AS oi
JOIN olist_orders_dataset AS ood on oi.order_id = ood.order_id
Where ood.order_status = 'delivered'
GROUP BY oi.seller_id)

SELECT seller_id,   total_revenue,    sum(total_revenue) OVER(ORDER BY total_revenue DESC)AS runningtotal,    SUM(total_revenue) OVER() AS grandtotal,   SUM(total_revenue) OVER(order by total_revenue DESC) / SUM(total_revenue) over() * 100 AS cumulative_percentage
FROM SellerRevenue
ORDER BY total_revenue DESC

