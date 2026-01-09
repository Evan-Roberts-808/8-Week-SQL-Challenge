-- What is the total amount each customer spent at the restaurant?

SELECT s.customer_id, SUM(m.price) as total_amount
FROM dannys_diner.sales s
LEFT JOIN dannys_diner.menu m on s.product_id = m.product_id
GROUP BY customer_id 
ORDER BY customer_id ASC
