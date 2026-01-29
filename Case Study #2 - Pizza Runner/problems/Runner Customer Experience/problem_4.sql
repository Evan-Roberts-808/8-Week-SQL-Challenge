-- What was the average distance travelled for each customer?
WITH completed_orders AS (
    SELECT
      co.order_id,
      co.customer_id,
      REGEXP_REPLACE(ro.distance, '[^0-9\.]', '', 'g')::NUMERIC AS cleaned_distance
    FROM pizza_runner.customer_orders co
    JOIN pizza_runner.runner_orders ro
      ON co.order_id = ro.order_id
    WHERE
      ro.cancellation IS NULL
      OR TRIM(LOWER(ro.cancellation)) IN ('', 'nan')
)
SELECT customer_id, ROUND(AVG(cleaned_distance), 1) AS average_distance_in_km 
FROM completed_orders
GROUP BY customer_id
ORDER BY average_distance_in_km
