SELECT
    pipeline_run_id,
    CASE
        WHEN COUNT(*) FILTER (WHERE status = 'FAIL') > 0
        THEN 'FAILED'
        ELSE 'PASSED'
    END AS pipeline_status
FROM analytics.data_quality_log
WHERE pipeline_run_id = :'run_id'
GROUP BY pipeline_run_id;