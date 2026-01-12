-- recreate a table that has customer_id order_date	product_name price member (Y/N)
SELECT s.customer_id, s.order_date, m.product_name, m.price, 
    CASE 
        WHEN mem.join_date > s.order_date THEN 'N'
        WHEN mem.join_date <= s.order_date THEN 'Y'
        ELSE 'N' END AS member_status
FROM dannys_diner.sales s
JOIN dannys_diner.members mem
    ON s.customer_id = mem.customer_id
JOIN dannys_diner.menu m
    ON s.product_id = m.product_id
ORDER BY s.customer_id, s.order_date
