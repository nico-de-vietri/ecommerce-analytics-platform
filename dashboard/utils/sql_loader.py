from pathlib import Path


def load_sql(filename):
    sql_path = Path("sql") / filename

    with open(sql_path) as f:
        return f.read()
