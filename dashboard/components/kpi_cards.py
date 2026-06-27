import streamlit as st
import pandas as pd
from utils.data_loader import load_dataframe


def render_kpis(engine, where_sql, params):
    # with open("sql/kpis.sql") as f:
    #    query = f.read()

    # query = query.format(where_clause=where_sql)

    # df = pd.read_sql(query, engine, params=params)
    df = load_dataframe(engine, "kpis.sql", where_sql=where_sql, params=params)

    print(query)
    print(params)
    print(df)
    print(df.dtypes)
    print(df.columns.tolist())

    orders = df["orders"][0]
    customers = df["customers"][0]
    revenue = df["revenue"][0]
    aov = df["aov"][0]
    delivery_rate = df["delivery_success_rate"][0]

    c1, c2, c3, c4, c5 = st.columns(5)

    c1.metric("Orders", f"{orders:,}")
    c2.metric("Customers", f"{customers:,}")
    c3.metric("Revenue", f"${revenue:,.0f}")
    c4.metric("AOV", f"${aov:.2f}")
    c5.metric("Delivered", f"{delivery_rate:.1f}%")
