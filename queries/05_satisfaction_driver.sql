
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
