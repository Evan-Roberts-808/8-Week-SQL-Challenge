-- What was the first item from the menu purchased by each customer?
SELECT DISTINCT ON (s.customer_id)
  s.customer_id,
  s.order_date,
  m.product_name
FROM dannys_diner.sales s
JOIN dannys_diner.menu m
  ON s.product_id = m.product_id
ORDER BY
  s.customer_id,
  s.order_date;

