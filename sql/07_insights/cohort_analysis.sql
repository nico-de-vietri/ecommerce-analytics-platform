WITH first_purchase AS (
    SELECT
        customer_id,
        DATE_TRUNC('month', MIN(order_purchase_timestamp)) AS cohort_month
    FROM analytics.fact_orders
    GROUP BY customer_id
),

user_activity AS (
    SELECT
        f.customer_id,
        DATE_TRUNC('month', f.order_purchase_timestamp) AS activity_month,
        fp.cohort_month
    FROM analytics.fact_orders f
    JOIN first_purchase fp
        ON f.customer_id = fp.customer_id
)

SELECT
    cohort_month,
    activity_month,
    (EXTRACT(YEAR FROM age(activity_month, cohort_month)) * 12 +
     EXTRACT(MONTH FROM age(activity_month, cohort_month))) AS month_number,
    COUNT(DISTINCT customer_id) AS active_customers
FROM user_activity
GROUP BY cohort_month, activity_month
ORDER BY cohort_month, activity_month;
