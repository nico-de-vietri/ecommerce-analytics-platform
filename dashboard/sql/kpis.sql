SELECT
    COUNT(DISTINCT fo.customer_unique_id) AS customers,
    COUNT(DISTINCT fo.order_id) AS orders,
    coalesce(SUM(fo.payment_value), 0) AS revenue,
    coalesce(ROUND(AVG(fo.payment_value), 2), 0) AS aov,
    coalesce(
    ROUND(
        100.0 * SUM(
            CASE
                WHEN order_status = 'delivered'
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ), 0) AS delivery_success_rate
FROM analytics.fact_orders fo
--JOIN staging.customers c
--ON fo.customer_id = c.customer_id
{where_clause}
;