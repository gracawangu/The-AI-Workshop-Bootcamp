
---For the top 5 customers by lifetime spend, show total number of orders and average order value

SELECT customer_id, name, SUM (quantity * price) AS total_revenue, 
	COUNT(order_id) AS total_orders,
	ROUND(AVG(quantity * price), 2) AS avg_order
FROM customers
INNER JOIN orders
	USING(customer_id)
INNER JOIN order_details
	USING (order_id)
INNER JOIN products
	USING(product_id)
GROUP BY customer_id, name
ORDER BY total_revenue DESC
LIMIT 5;