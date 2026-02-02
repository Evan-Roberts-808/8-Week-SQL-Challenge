-- What was the average speed for each runner for each delivery and do you notice any trend for these values?

-- we need to fine average speed for each runner, we can calculate speed in mph using the distance traveled and duration it took to make the drive

WITH cleaned AS (
  SELECT
    order_id,
    runner_id,
    REGEXP_REPLACE(distance, '[^0-9\.]', '', 'g')::NUMERIC AS distance_km,
    REGEXP_REPLACE(duration, '[^0-9\.]', '', 'g')::NUMERIC AS duration_min
  FROM pizza_runner.runner_orders
  WHERE
    distance IS NOT NULL
    AND TRIM(LOWER(distance)) <> 'null'
    AND duration IS NOT NULL
    AND TRIM(LOWER(duration)) <> 'null'
    AND (
      cancellation IS NULL
      OR TRIM(LOWER(cancellation)) IN ('', 'nan')
    )
)

SELECT
  runner_id,
  order_id,
  ROUND((distance_km / duration_min) * 60, 2) AS speed_kmh
FROM cleaned
ORDER BY runner_id, order_id;


