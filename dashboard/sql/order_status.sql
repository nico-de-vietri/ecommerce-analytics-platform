SELECT
    fo.order_status,
    COUNT(*) AS orders
<<<<<<< HEAD
FROM analytics.fact_orders fo
JOIN staging.customers c
    ON fo.customer_id = c.customer_id

{where_clause}
=======
FROM analytics.fact_orders
WHERE order_status <> 'delivered'
>>>>>>> 0236f39 (Dashboard Improvement)
GROUP BY order_status
ORDER BY orders DESC;
/*SELECT
    ROUND(
        100.0 * SUM(
            CASE
                WHEN order_status='delivered'
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS delivery_success_rate
    FROM analytics.fact_orders;*/