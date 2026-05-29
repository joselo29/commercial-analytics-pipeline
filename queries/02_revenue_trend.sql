-- Business Question 1: Monthly revenue and order volume trend
--COUNT(DISTINCT order_id) is used because the join to order_items returns one row per item, so a multi-item order would otherwise be counted several times.
--Revenue is SUM(oi.price) from order_items, since price is stored at the item level rather than on the order.
--The delivered filter is applied here so cancelled and undelivered orders do not inflate revenue or the order count.
SELECT
    YEAR(order_purchase_timestamp) AS order_year,
    MONTH(order_purchase_timestamp) AS order_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.price) AS total_revenue
FROM olist_orders_dataset AS o
JOIN olist_order_items_dataset AS oi
ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY YEAR(order_purchase_timestamp), MONTH(order_purchase_timestamp)
ORDER BY order_year, order_month