-- How many days has each customer visited the restaurant?
SELECT customer_id, COUNT(DISTINCT order_date) as unique_dates
FROM dannys_diner.sales
GROUP BY customer_id
ORDER BY unique_dates ASC