import pandas as pd
import streamlit as st
from utils.data_loader import load_dataframe


def render_insights(engine):

    query = open("sql/executive_summary.sql").read()

    # summary = pd.read_sql(query, engine)
    summary = load_dataframe(engine, "executive_summary.sql")

    row = summary.iloc[0]

    category = row["top_category"].replace("_", " ").title()

    st.header("Executive Insights")

    insights = f"""
**{row['top_state']}** is the company's largest market, generating **{row['top_state_revenue_pct']}%** of total revenue (${row['top_state_revenue']:,.0f}).

**{category}** is the top-performing category, contributing **{row['top_category_revenue_pct']}%** of revenue (${row['top_category_revenue']:,.0f}) across **{row['top_category_orders']:,} orders**.

Only **{row['repeat_customer_pct']}%** of customers placed more than one order, highlighting a significant customer retention opportunity.

The business maintains a **{row['delivery_success_rate']}% delivery success rate**, indicating strong operational performance.
"""

    st.info(insights)
