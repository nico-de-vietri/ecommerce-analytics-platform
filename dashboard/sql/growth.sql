WITH monthly AS (
    SELECT
        DATE_TRUNC('month', order_purchase_timestamp) AS month,
        SUM(payment_value) AS revenue
    FROM analytics.fact_orders
    GROUP BY 1
)
SELECT
    ROUND(
        (
            MAX(revenue)
            - MIN(revenue)
        )
        /
        NULLIF(MIN(revenue),0)
        * 100,
        2
    ) AS growth_pct
FROM monthly;