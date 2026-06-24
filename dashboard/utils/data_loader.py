import pandas as pd
from utils.sql_loader import load_sql


def load_dataframe(engine, sql_file, where_sql="", params=None):

    query = load_sql(sql_file)

    query = query.format(where_clause=where_sql)

    return pd.read_sql(query, engine, params=params)
