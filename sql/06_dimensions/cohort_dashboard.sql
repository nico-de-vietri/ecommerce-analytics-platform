WITH first_purchase AS (
    SELECT
        customer_id,
        DATE_TRUNC('month', MIN(order_purchase_timestamp)) AS cohort_month
    FROM analytics.fact_orders
    GROUP BY customer_id
),

orders_with_cohort AS (
    SELECT
        f.customer_id,
        fp.cohort_month,
        f.payment_value
    FROM analytics.fact_orders f
    JOIN first_purchase fp
        ON f.customer_id = fp.customer_id
),

cohort_metrics AS (
    SELECT
        cohort_month,
        COUNT(DISTINCT customer_id) AS cohort_size,
        SUM(payment_value) AS total_revenue,
        SUM(payment_value) / COUNT(DISTINCT customer_id) AS avg_revenue_per_customer
    FROM orders_with_cohort
    GROUP BY cohort_month
),

total_revenue AS (
    SELECT SUM(payment_value) AS global_revenue
    FROM analytics.fact_orders
)

SELECT
    c.cohort_month,
    c.cohort_size,
    c.total_revenue,
    c.avg_revenue_per_customer,
    ROUND(
        (c.total_revenue / t.global_revenue) * 100,
        2
    ) AS revenue_share_pct
FROM cohort_metrics c
CROSS JOIN total_revenue t
ORDER BY c.cohort_month;
