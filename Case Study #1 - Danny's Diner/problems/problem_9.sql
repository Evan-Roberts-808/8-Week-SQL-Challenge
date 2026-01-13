-- If each $1 spent equates to 10 points and sushi has a 2x points multiplier
-- how many points would each customer have?

-- select customer_id, some sort of aggregate where we can conditionally create a sum based on values, if value is sushi +20 otherwise +10,
-- from sales as s
-- join menu on product_id
-- group by whatever is necessary to not error from aggregation
-- order by customer_id

SELECT s.customer_id, SUM(CASE WHEN m.product_name = 'sushi' THEN (m.price * 20) ELSE (m.price * 10) END) as total_points
FROM dannys_diner.sales AS s
JOIN dannys_diner.menu AS m
ON s.product_id = m.product_id
GROUP BY s.customer_id
ORDER BY s.customer_id