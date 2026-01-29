-- What was the total volume of pizzas ordered for each hour of the day?
SELECT
    EXTRACT(HOUR FROM order_time) as hour_of_day,
    COUNT(*) as pizza_volume
FROM pizza_runner.customer_orders
GROUP BY hour_of_day
ORDER BY hour_of_day ASC