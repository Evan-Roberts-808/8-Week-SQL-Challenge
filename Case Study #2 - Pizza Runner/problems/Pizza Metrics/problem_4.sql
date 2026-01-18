-- How many of each type of pizza was delivered?
-- CTE to find successful orders
WITH successful_orders AS (
  SELECT order_id
  FROM pizza_runner.runner_orders
  WHERE
    cancellation IS NULL
    OR TRIM(cancellation) IN ('', 'NaN')
)

SELECT
  pn.pizza_name,
  COUNT(*) AS delivered_count
FROM pizza_runner.customer_orders co
JOIN successful_orders so
  ON co.order_id = so.order_id
JOIN pizza_runner.pizza_names pn
  ON co.pizza_id = pn.pizza_id
GROUP BY pn.pizza_name
ORDER BY delivered_count;