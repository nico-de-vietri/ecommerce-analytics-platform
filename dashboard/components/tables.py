import pandas as pd
import streamlit as st


def render_top_customers(engine):

    query = open("sql/top_customers.sql").read()

    df = pd.read_sql(query, engine)

    st.subheader("Top Customers")
    st.dataframe(df, use_container_width=True, hide_index=True)
