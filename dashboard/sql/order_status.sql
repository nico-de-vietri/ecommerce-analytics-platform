SELECT
    order_status,
    COUNT(*) AS orders
FROM analytics.fact_orders
GROUP BY order_status
ORDER BY orders DESC;