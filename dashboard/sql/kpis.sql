SELECT
    COUNT(DISTINCT c.customer_unique_id) AS customers,
    COUNT(DISTINCT fo.order_id) AS orders,
    SUM(fo.payment_value) AS revenue,
    ROUND(AVG(fo.payment_value), 2) AS aov
FROM analytics.fact_orders fo
JOIN staging.customers c
ON fo.customer_id = c.customer_id;