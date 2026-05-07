--Find drivers whose cancellation rate is above 10% and who have made at least 100 trips

SELECT driver_id, name,
    COUNT(trip_id) AS total_trips,
    COUNT(CASE WHEN status = 'Cancelled' THEN 1 END) AS cancelled_trips,
	ROUND(COUNT(CASE WHEN status = 'Cancelled' THEN 1 END)::decimal / COUNT(trip_id) * 100, 2) AS cancellation_rate
FROM delivery_trips
INNER JOIN drivers
    USING (driver_id)
GROUP BY driver_id, name
HAVING 
	COUNT(trip_id) >= 100
	AND(COUNT(CASE WHEN status = 'Cancelled' THEN 1 END)::decimal / COUNT(trip_id) * 100) > 10;
	
SELECT driver_id, name,
    COUNT(trip_id) AS total_trips,
    COUNT(CASE WHEN status = 'Cancelled' THEN 1 END) AS cancelled_trips,
    ROUND(COUNT(CASE WHEN status = 'Cancelled' THEN 1 END)::decimal / COUNT(trip_id), 2) AS cancellation_rate
FROM drivers 
JOIN delivery_trips 
    USING(driver_id)
GROUP BY driver_id, name
HAVING 
    COUNT(trip_id) >= 100
    AND(COUNT(CASE WHEN status = 'Cancelled' THEN 1 END)::decimal / COUNT(trip_id)) > 0.10;