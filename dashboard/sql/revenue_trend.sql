SELECT
    DATE_TRUNC('month', order_purchase_timestamp)::date AS month,
    SUM(fo.payment_value) AS revenue,
    COUNT(DISTINCT c.customer_unique_id) AS customers,
    COUNT(DISTINCT order_id) AS orders,
    ROUND(SUM(payment_value) / COUNT(order_id), 2) AS aov
FROM analytics.fact_orders fo
JOIN staging.customers c
    ON fo.customer_id = c.customer_id
GROUP BY 1
ORDER BY 1;