-- What was the most commonly added extra?
-- extras from customer_orders is either null, or a TEXT of comma separated values,
-- we can separate the text then count the corresponding ids selecting the MAX
-- and join with pizza_toppings to get the topping name

WITH extra_toppings AS (
    SELECT
      TRIM(t.topping_id)::INT AS topping_id
    FROM pizza_runner.customer_orders co
    JOIN LATERAL
      UNNEST(string_to_array(co.extras, ',')) AS t(topping_id)
      ON TRUE
    WHERE
      co.extras IS NOT NULL
      AND TRIM(LOWER(co.extras)) NOT IN ('', 'null', 'nan')
)
SELECT
  pt.topping_name,
  COUNT(*) AS times_ordered
FROM extra_toppings et
JOIN pizza_runner.pizza_toppings pt
  ON et.topping_id = pt.topping_id
GROUP BY pt.topping_name
ORDER BY times_ordered DESC
LIMIT 1;

