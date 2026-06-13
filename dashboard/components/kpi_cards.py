import streamlit as st
import pandas as pd


def render_kpis(engine):
    with open("sql/kpis.sql") as f:
        query = f.read()

    df = pd.read_sql(query, engine)

    orders = df["orders"][0]
    customers = df["customers"][0]
    revenue = df["revenue"][0]
    aov = df["aov"][0]

    c1, c2, c3, c4 = st.columns(4)

    c1.metric("Orders", f"{orders:,}")
    c2.metric("Customers", f"{customers:,}")
    c3.metric("Revenue", f"${revenue:,.0f}")
    c4.metric("AOV", f"${aov:.2f}")
