SELECT
    COUNT(DISTINCT pipeline_run_id) AS total_pipeline_runs
FROM analytics.data_quality_log;


WITH current_run AS (
    SELECT *
    FROM analytics.data_quality_log
    WHERE pipeline_run_id = :'run_id'
),
previous_run_id AS (
    SELECT pipeline_run_id
    FROM analytics.data_quality_log
    WHERE pipeline_run_id <> :'run_id'
    ORDER BY run_timestamp DESC
    LIMIT 1
),
previous_run AS (
    SELECT *
    FROM analytics.data_quality_log
    WHERE pipeline_run_id = (
        SELECT pipeline_run_id
        FROM previous_run_id
    )
)
SELECT
    c.check_name,
    COALESCE(p.metric, 'N/A') AS previous_metric,
    c.metric AS current_metric,
    CASE
        WHEN p.metric IS NULL THEN 'FIRST_RUN'
        WHEN p.metric = c.metric THEN 'UNCHANGED'
        ELSE 'CHANGED'
    END AS comparison
FROM current_run c
LEFT JOIN previous_run p
    ON c.check_name = p.check_name
ORDER BY c.check_name;