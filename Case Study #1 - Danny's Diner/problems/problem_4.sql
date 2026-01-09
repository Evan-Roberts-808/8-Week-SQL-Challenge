-- What is the most purchased item on the menu 
-- and how many times was it purchased by all customers?

SELECT m.product_name, COUNT(s.product_id) as purchase_count
FROM dannys_diner.sales s
JOIN dannys_diner.menu m ON s.product_id = m.product_id
GROUP BY m.product_name
ORDER BY purchase_count DESC
LIMIT 1
