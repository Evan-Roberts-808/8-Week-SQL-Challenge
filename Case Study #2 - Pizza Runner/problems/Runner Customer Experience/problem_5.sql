-- What was the difference between the longest 
-- and shortest delivery times for all orders?

WITH delivery_times AS (
  SELECT
    REGEXP_REPLACE(duration, '[^0-9\.]', '', 'g')::NUMERIC AS delivery_minutes
  FROM pizza_runner.runner_orders
  WHERE
    duration IS NOT NULL
    AND TRIM(LOWER(duration)) <> 'null'
    AND (
      cancellation IS NULL
      OR TRIM(LOWER(cancellation)) IN ('', 'nan')
    )
)
SELECT
  MAX(delivery_minutes) - MIN(delivery_minutes)
    AS delivery_time_difference_minutes
FROM delivery_times;