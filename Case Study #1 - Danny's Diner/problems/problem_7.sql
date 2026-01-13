-- Which item was purchased just before the customer became a member?

-- we need to return customer_id and product_name
-- from a selection that finds customer_id, product_id, order_date and join_date,
-- which is partitioned by customer_id
-- joining members and sales on customer_id
-- where the order date is less than or equal to join date to specifically find ones before they joined ordered descending
-- then join menu to get product names on product_id, and pull our rank 1 from the partition which should be the closest date to joining

SELECT r.customer_id, m.product_name as closest_purchase_before_joining,  r.order_date,
  r.join_date
FROM (
SELECT s.customer_id, s.product_id, s.order_date, mem.join_date, ROW_NUMBER() OVER (
    PARTITION BY s.customer_id
    ORDER BY s.order_date DESC
) AS rn
FROM dannys_diner.sales s
JOIN dannys_diner.members mem ON s.customer_id = mem.customer_id
WHERE s.order_date <= mem.join_date
) AS r
JOIN dannys_diner.menu m ON r.product_id = m.product_id
WHERE r.rn = 1
ORDER BY r.customer_id