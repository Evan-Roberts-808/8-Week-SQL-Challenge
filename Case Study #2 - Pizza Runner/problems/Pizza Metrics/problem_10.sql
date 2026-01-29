-- What was the volume of orders for each day of the week?
SELECT
    TO_CHAR(order_time, 'Day') AS day_of_week,
    COUNT(*) AS pizza_volume
FROM pizza_runner.customer_orders
GROUP BY day_of_week
ORDER BY pizza_volume DESC