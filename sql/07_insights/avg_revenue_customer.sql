WITH first_purchase AS (
    SELECT
        customer_id,
        DATE_TRUNC('month', MIN(order_purchase_timestamp)) AS cohort_month
    FROM analytics.fact_orders
    GROUP BY customer_id
)

SELECT
    fp.cohort_month,
    SUM(f.payment_value) AS total_revenue,
    COUNT(DISTINCT f.customer_id) AS customers,
    SUM(f.payment_value) / COUNT(DISTINCT f.customer_id) AS avg_revenue_per_customer
FROM analytics.fact_orders f
JOIN first_purchase fp
    ON f.customer_id = fp.customer_id
GROUP BY fp.cohort_month
ORDER BY fp.cohort_month;