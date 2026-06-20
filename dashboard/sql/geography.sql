SELECT
    customer_state,
    revenue
FROM analytics.mart_geography
ORDER BY revenue DESC
LIMIT 10;