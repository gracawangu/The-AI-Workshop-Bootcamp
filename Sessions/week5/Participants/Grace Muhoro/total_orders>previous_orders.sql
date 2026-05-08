--Find any day where total orders were more than double the previous day

WITH daily_orders AS 	
	(SELECT order_date, COUNT(order_id) AS total_orders, LAG(COUNT(*)) OVER (ORDER BY order_date) AS previous_day_orders
    FROM orders
    GROUP BY order_date)
SELECT *
FROM daily_orders
WHERE total_orders > 2 * previous_day_orders;