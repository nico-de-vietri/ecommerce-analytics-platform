import pandas as pd
import streamlit as st


def render_insights(engine):

    query = open("sql/executive_summary.sql").read()

    summary = pd.read_sql(query, engine)

    row = summary.iloc[0]

    # prettify category name
    category = row["top_category"].replace("_", " ").title()

    st.header("Executive Insights")

    st.info(f"""
• {row['top_state']} is the largest revenue-generating market.

• {category} is the top-performing product category.

• Only {row['repeat_customer_pct']}% of customers place more than one order.
""")
