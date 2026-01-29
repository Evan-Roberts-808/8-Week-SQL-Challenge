-- What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
-- we need time from customer orders timestamp, then we can use runner_orders pickup_time, subtract one from the other and form that as a CTE then select the AVG from that CTE
WITH pickup_times AS (
  SELECT
    ro.runner_id,
    EXTRACT(
      EPOCH FROM (
        ro.pickup_time::TIMESTAMP - co.order_time
      )
    ) / 60 AS minutes_to_pickup
  FROM pizza_runner.runner_orders ro
  JOIN pizza_runner.customer_orders co
    ON ro.order_id = co.order_id
  WHERE
    ro.pickup_time IS NOT NULL
    AND TRIM(ro.pickup_time) <> ''
    AND (
      ro.cancellation IS NULL
      OR TRIM(LOWER(ro.cancellation)) IN ('', 'nan')
    )
)
SELECT
  runner_id,
  ROUND(AVG(minutes_to_pickup), 2) AS avg_minutes_to_pickup
FROM pickup_times
GROUP BY runner_id
ORDER BY runner_id;
