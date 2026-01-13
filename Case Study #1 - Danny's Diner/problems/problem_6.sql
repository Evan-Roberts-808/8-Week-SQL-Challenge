-- Which item was purchased first by the customer after they became a member?

-- Notes:
-- we need to find the first sales entry AFTER each uers members.join_date
-- from there we then have the product_id but for brevity should probably get proudct name from menu

-- customer must exist in members
-- Only consider sales where sales.order_date >= members.join_date
-- For each customer, sort those qualifying purchases by order_date
-- Pick the earliest one
SELECT r.customer_id, m.product_name as first_purchased_product 
FROM (
SELECT s.customer_id, s.product_id, s.order_date, mem.join_date, ROW_NUMBER() OVER (
    PARTITION BY s.customer_id
    ORDER BY s.order_date ASC
) AS rn
FROM dannys_diner.sales s
JOIN dannys_diner.members mem ON s.customer_id = mem.customer_id
WHERE s.order_date >= mem.join_date
) as r
JOIN dannys_diner.menu m ON r.product_id = m.product_id
WHERE r.rn = 1