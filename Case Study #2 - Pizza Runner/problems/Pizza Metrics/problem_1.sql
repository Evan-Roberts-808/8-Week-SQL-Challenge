-- How many pizzas were ordered?

-- need to count the number of customer_orders, theres only 1 pizza to an order
SELECT COUNT(pizza_id) AS pizzas_sold
FROM pizza_runner.customer_orders