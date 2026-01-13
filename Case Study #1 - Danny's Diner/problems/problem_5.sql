-- Which item was the most popular for each customer?
SELECT
  customer_id,
  product_name,
  purchase_count
FROM (
  SELECT
    s.customer_id,
    m.product_name,
    COUNT(*) AS purchase_count,
    ROW_NUMBER() OVER (
      PARTITION BY s.customer_id
      ORDER BY COUNT(*) DESC
    ) AS rn
  FROM dannys_diner.sales s
  JOIN dannys_diner.menu m
    ON s.product_id = m.product_id
  GROUP BY s.customer_id, m.product_name
) ranked
WHERE rn = 1
ORDER BY customer_id;

