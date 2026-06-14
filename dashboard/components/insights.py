import pandas as pd
import streamlit as st


def render_insights(engine):

    query = open("sql/executive_summary.sql").read()

    summary = pd.read_sql(query, engine)

    row = summary.iloc[0]

    category = row["top_category"].replace("_", " ").title()

    st.header("Executive Insights")

    insights = f"""
• {row['top_state']} generated ${row['top_state_revenue']:,.0f} in revenue, making it the largest market.

• {category} is the highest-performing category with ${row['top_category_revenue']:,.0f} in sales across {row['top_category_orders']:,} orders.

• Only {row['repeat_customer_pct']}% of customers placed more than one order, highlighting a potential opportunity to improve customer retention.
"""

    st.info(insights)
