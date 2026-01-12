-- What is the total items and amount 
-- spent for each member before they became a member?

-- we need to select customer_id, COUNT product_id from sales per customer, 
-- SUM price from menu per customer 
-- from sales
-- joining members on customer id 
-- joining menu on product id -- ordered by customer id
-- where order date <= join date 


SELECT s.customer_id, COUNT(s.product_id) as total_purchases, SUM(m.price) as total_spent
FROM dannys_diner.sales s
JOIN dannys_diner.members mem
ON s.customer_id = mem.customer_id
JOIN dannys_diner.menu m
ON s.product_id = m.product_id
WHERE s.order_date <= mem.join_date
GROUP BY s.customer_id
ORDER BY s.customer_id