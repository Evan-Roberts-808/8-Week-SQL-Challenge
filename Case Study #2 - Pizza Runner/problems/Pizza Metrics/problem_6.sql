-- What was the maximum number of pizzas delivered in a single order?
WITH pizzas_delivered AS (
    SELECT co.order_id, COUNT(*) as pizzas_delivered
    FROM pizza_runner.customer_orders co
    JOIN pizza_runner.runner_orders ro
    ON co.order_id = ro.order_id
    WHERE cancellation IS NULL OR TRIM(cancellation) IN ('', 'NaN')
    GROUP BY co.order_id
)
SELECT MAX(pizzas_delivered) AS max_pizzas_delivered
FROM pizzas_delivered