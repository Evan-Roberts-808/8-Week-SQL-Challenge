-- How many pizzas were delivered that had both exclusions and extras?
-- lets get a collection of the delivered pizzas with a CTE
-- then we can select from there with a where clause checking for non null nan or empty string values

WITH delivered_pizzas AS (
    SELECT
      co.order_id,
      CASE
        WHEN co.exclusions IS NULL
          OR TRIM(LOWER(co.exclusions)) IN ('', 'null', 'nan')
        THEN 0 ELSE 1
      END AS has_exclusions,
      CASE
        WHEN co.extras IS NULL
          OR TRIM(LOWER(co.extras)) IN ('', 'null', 'nan')
        THEN 0 ELSE 1
      END AS has_extras
    FROM pizza_runner.customer_orders co
    JOIN pizza_runner.runner_orders ro
      ON co.order_id = ro.order_id
    WHERE
      ro.cancellation IS NULL
      OR TRIM(LOWER(ro.cancellation)) IN ('', 'nan')
)
SELECT
  COUNT(*) AS pizzas_with_both_exclusions_and_extras
FROM delivered_pizzas
WHERE has_exclusions = 1
  AND has_extras = 1;