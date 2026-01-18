-- How many Vegetarian and Meatlovers were ordered by each customer?
-- select customer_id, count *, pizza name join pizza names on pizza id 
-- where pizza name is vegetarian or meatlovers
-- group by customer_id, pizza name

SELECT co.customer_id, COUNT(*) AS pizzas_ordered, pn.pizza_name
FROM pizza_runner.customer_orders co
JOIN pizza_runner.pizza_names pn
ON co.pizza_id = pn.pizza_id
WHERE LOWER(pizza_name) = 'vegetarian' OR LOWER(pizza_name) = 'meatlovers'
GROUP BY co.customer_id, pn.pizza_name
ORDER BY co.customer_id, pn.pizza_name