CREATE TABLE IF NOT EXISTS analytics.data_quality_log (
    id SERIAL PRIMARY KEY,
    check_name TEXT NOT NULL,
    metric TEXT,
    status TEXT,
    run_timestamp TIMESTAMP DEFAULT NOW()
);