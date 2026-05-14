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