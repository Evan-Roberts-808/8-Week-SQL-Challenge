-- For each customer, how many delivered pizzas had at least 1 change 
-- and how many had no changes?
WITH delivered_pizzas AS (
  SELECT
    co.customer_id,
    CASE
      WHEN
        (co.exclusions IS NULL OR TRIM(LOWER(co.exclusions)) IN ('', 'null', 'nan'))
        AND
        (co.extras IS NULL OR TRIM(LOWER(co.extras)) IN ('', 'null', 'nan'))
      THEN 'no_change'
      ELSE 'change'
    END AS change_type
  FROM pizza_runner.customer_orders co
  JOIN pizza_runner.runner_orders ro
    ON co.order_id = ro.order_id
  WHERE
    ro.cancellation IS NULL
    OR TRIM(LOWER(ro.cancellation)) IN ('', 'nan')
)
SELECT
  customer_id,
  SUM(CASE WHEN change_type = 'change' THEN 1 ELSE 0 END) AS pizzas_with_changes,
  SUM(CASE WHEN change_type = 'no_change' THEN 1 ELSE 0 END) AS pizzas_without_changes
FROM delivered_pizzas
GROUP BY customer_id
ORDER BY customer_id;
