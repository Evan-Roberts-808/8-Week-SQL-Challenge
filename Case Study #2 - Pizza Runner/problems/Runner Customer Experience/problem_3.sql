-- Is there any relationship between the number of pizzas 
-- and how long the order takes to prepare?

-- We will assume prep time starts as soon as its placed
-- and completion time is as soon as it is picked up

WITH order_prep AS (
    SELECT co.order_id,
    COUNT(*) AS pizza_count,
    EXTRACT(
        EPOCH FROM (
            ro.pickup_time::TIMESTAMP - MIN(co.order_time)
        )
    ) / 60 AS prep_minutes
    FROM pizza_runner.customer_orders co
    JOIN pizza_runner.runner_orders ro
        ON co.order_id = ro.order_id
    WHERE
        ro.pickup_time IS NOT NULL
        AND TRIM(ro.pickup_time) <> ''
        AND (
            ro.cancellation IS NULL
            OR TRIM(LOWER(ro.cancellation)) IN ('', 'nan')
        )
    GROUP BY co.order_id, ro.pickup_time
)
SELECT *
FROM order_prep
ORDER BY pizza_count

-- We can see from this query that as the 
-- pizza count increases as does our prep minutes