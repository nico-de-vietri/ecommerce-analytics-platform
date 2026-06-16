SELECT
    fo.order_status,
    COUNT(*) AS orders
FROM analytics.fact_orders fo
JOIN staging.customers c
    ON fo.customer_id = c.customer_id

{where_clause}
GROUP BY order_status
ORDER BY orders DESC;