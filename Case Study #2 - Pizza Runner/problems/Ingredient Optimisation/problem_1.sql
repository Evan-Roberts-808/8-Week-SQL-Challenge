-- What are the standard ingredients for each pizza?

-- pizza_recipes has a comma separated text of topping ids,
-- we can split this at the commas and select out the topping names from the pizza_toppings table
SELECT
  pn.pizza_name,
  pt.topping_name
FROM pizza_runner.pizza_recipes pr
JOIN pizza_runner.pizza_names pn
  ON pr.pizza_id = pn.pizza_id
JOIN LATERAL
  UNNEST(string_to_array(pr.toppings, ',')) AS t(topping_id)
  ON TRUE
JOIN pizza_runner.pizza_toppings pt
  ON TRIM(t.topping_id)::INT = pt.topping_id
ORDER BY pn.pizza_name, pt.topping_id;

