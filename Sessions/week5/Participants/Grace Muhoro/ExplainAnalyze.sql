--Pick one of your queries. Run EXPLAIN ANALYZE. Paste the output into an AI tool. Write down the first suggestion it gave and whether it actually helped
EXPLAIN ANALYZE
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

WITH filtered_orders AS 
    (SELECT order_id
    FROM orders
    WHERE order_date >= DATE '2024-01-01'
    AND order_date <  DATE '2025-01-01')
SELECT department_id, department_name,
    SUM(quantity * price) AS total_revenue_2024
FROM filtered_orders 
JOIN order_details od USING(order_id)
JOIN products USING(product_id)
JOIN departments USING(department_id)
GROUP BY department_id, department_name
ORDER BY total_revenue_2024 DESC;