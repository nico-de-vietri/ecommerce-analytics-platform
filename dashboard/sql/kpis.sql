SELECT
    COUNT(DISTINCT c.customer_unique_id) AS customers,
    COUNT(DISTINCT fo.order_id) AS orders,
    SUM(fo.payment_value) AS revenue,
    ROUND(AVG(fo.payment_value), 2) AS aov,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN order_status = 'delivered'
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS delivery_success_rate
FROM analytics.fact_orders fo
JOIN staging.customers c
ON fo.customer_id = c.customer_id
{where_clause}
;