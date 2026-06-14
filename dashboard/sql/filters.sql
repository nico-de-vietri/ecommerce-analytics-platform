SELECT 
(SELECT DISTINCT customer_state
FROM analytics.mart_geography
ORDER BY customer_state) as states,

(SELECT DISTINCT product_category_name
FROM analytics.mart_product_category
ORDER BY product_category_name) as categories