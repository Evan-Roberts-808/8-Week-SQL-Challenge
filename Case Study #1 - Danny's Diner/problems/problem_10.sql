-- In the first week after a customer joins the program (including their join date) 
-- they earn 2x points on all items, not just sushi -
-- how many points do customer A and B have at the end of January?

-- we select customer_id, and SUM price * 2 where sales_date is between join date and join_date + interval 6 days otherwise price,
-- from sales
-- joined menu on product_id
-- joined members on customer_id
-- group by customer id
-- order by customer id

SELECT s.customer_id, SUM(CASE WHEN s.order_date BETWEEN mem.join_date AND mem.join_date + INTERVAL '6 days' THEN (m.price * 20) ELSE (m.price * 10) END)
FROM dannys_diner.sales s
JOIN dannys_diner.menu m ON s.product_id = m.product_id
JOIN dannys_diner.members mem ON s.customer_id = mem.customer_id
WHERE s.order_date <= '2021-01-31'
GROUP BY s.customer_id
ORDER BY s.customer_id