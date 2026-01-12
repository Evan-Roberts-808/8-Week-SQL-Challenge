-- query the previous table but include ranking of customers products, nullify if order happened before they were a member

WITH base AS (
  SELECT
    s.customer_id,
    s.order_date,
    m.product_name,
    m.price,
    CASE
      WHEN mem.join_date <= s.order_date THEN 'Y'
      ELSE 'N'
    END AS member_status
  FROM dannys_diner.sales s
  JOIN dannys_diner.menu m
    ON s.product_id = m.product_id
  LEFT JOIN dannys_diner.members mem
    ON s.customer_id = mem.customer_id
)
SELECT
  *,
  CASE
    WHEN member_status = 'Y'
      THEN RANK() OVER (
        PARTITION BY customer_id
        ORDER BY order_date
      )
    ELSE NULL
  END AS ranking
FROM base
ORDER BY customer_id, order_date;
