SELECT
    customer_unique_id,
    COUNT(*) AS orders,
    SUM(payment_value) AS revenue
FROM analytics.fact_orders
GROUP BY customer_unique_id
ORDER BY revenue DESC
LIMIT 10;