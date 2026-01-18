-- How many successful orders were delivered by each runner?
-- COUNT DISTINCT order_id to ensure 1 delivery per order
SELECT runner_id, COUNT(DISTINCT order_id) as successful_orders
FROM pizza_runner.runner_orders
WHERE cancellation IS NULL OR TRIM(cancellation) IN ('', 'NaN')
GROUP BY runner_id
ORDER BY runner_id ASC