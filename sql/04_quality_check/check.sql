WITH row_integrity_checks AS (
    SELECT
        'row_integrity_orders' AS check_name,
        COUNT(*)::text AS metric,
        CASE WHEN COUNT(*) = COUNT(DISTINCT order_id)
             THEN 'PASS' ELSE 'FAIL' END AS status
    FROM staging.orders
),

uniqueness_checks AS (
    SELECT
        'duplicate_orders' AS check_name,
        COUNT(*)::text AS metric,
        CASE WHEN COUNT(*) = 0
             THEN 'PASS' ELSE 'FAIL' END AS status
    FROM (
        SELECT order_id
        FROM staging.orders
        GROUP BY order_id
        HAVING COUNT(*) > 1
    ) t
),

relationship_validation AS (
    SELECT
        'orphan_orders' AS check_name,
        COUNT(*)::text AS metric,
        CASE WHEN COUNT(*) = 0
             THEN 'PASS' ELSE 'FAIL' END AS status
    FROM staging.orders o
    LEFT JOIN staging.customers c
        ON o.customer_id = c.customer_id
    WHERE c.customer_id IS NULL
),

null_completeness_check AS (
    SELECT
        'missing_order_purchase_timestamp' AS check_name,
        COUNT(*)::text AS metric,
        CASE WHEN COUNT(*) = 0
             THEN 'PASS' ELSE 'FAIL' END AS status
    FROM staging.orders
    WHERE order_purchase_timestamp IS NULL
),

business_sanity_check AS (
    SELECT
        'order_date_range' AS check_name,
        (MIN(order_purchase_timestamp)::text || ' → ' ||
         MAX(order_purchase_timestamp)::text) AS metric,
        'INFO' AS status
    FROM staging.orders
),


quality_report as (
SELECT * FROM row_integrity_checks
UNION ALL
SELECT * FROM uniqueness_checks
UNION ALL
SELECT * FROM relationship_validation
UNION ALL
SELECT * FROM null_completeness_check
UNION ALL
SELECT * FROM business_sanity_check)

INSERT INTO analytics.data_quality_log (pipeline_run_id, check_name, metric, status)
--SELECT check_name, metric, status FROM quality_report;
SELECT
    :'run_id',
    check_name,
    metric,
    status
FROM quality_report;

SELECT
    pipeline_run_id,
    check_name,
    metric,
    status
FROM analytics.data_quality_log
WHERE pipeline_run_id = :'run_id'
ORDER BY id;