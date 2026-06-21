SELECT
    order_status,
    COUNT(*) AS orders
FROM analytics.fact_orders
WHERE order_status <> 'delivered'
GROUP BY order_status
ORDER BY orders DESC;