SELECT
    pipeline_run_id,
    COUNT(*) AS checks,
    MIN(run_timestamp) AS started_at
FROM analytics.data_quality_log
GROUP BY pipeline_run_id
ORDER BY started_at DESC;