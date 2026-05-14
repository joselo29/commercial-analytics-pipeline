

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
