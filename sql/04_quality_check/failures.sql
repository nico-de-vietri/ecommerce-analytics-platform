SELECT *
FROM analytics.data_quality_log
WHERE status = 'FAIL'
ORDER BY run_timestamp DESC;