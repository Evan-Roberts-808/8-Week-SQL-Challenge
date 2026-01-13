-- recreate a table that has customer_id order_date	product_name price member (Y/N)
SELECT
  s.customer_id,
  s.order_date,
  m.product_name,
  m.price,
  CASE
    WHEN mem.join_date IS NOT NULL
     AND s.order_date >= mem.join_date THEN 'Y'
    ELSE 'N'
  END AS member_status
FROM dannys_diner.sales s
JOIN dannys_diner.menu m
  ON s.product_id = m.product_id
LEFT JOIN dannys_diner.members mem
  ON s.customer_id = mem.customer_id
ORDER BY s.customer_id, s.order_date;

