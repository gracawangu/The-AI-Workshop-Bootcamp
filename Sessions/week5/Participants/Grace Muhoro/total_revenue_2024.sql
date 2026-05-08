--For each department, show the total revenue generated in 2024 (quantity × price across all orders in 2024)

SELECT department_id, department_name, SUM (quantity * price) AS total_revenue_2024
FROM departments
INNER JOIN products
	USING (department_id)
INNER JOIN order_details
	USING (product_id)
INNER JOIN orders
	USING(order_id) 
WHERE order_date >= '2024-01-01' 
	AND order_date < '2025-01-01'
GROUP BY department_id, department_name
ORDER BY total_revenue_2024 DESC
