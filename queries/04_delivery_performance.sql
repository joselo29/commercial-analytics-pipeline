
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