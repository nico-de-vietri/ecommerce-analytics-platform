import pandas as pd
import streamlit as st
from utils.data_loader import load_dataframe


def render_top_customers(engine):

    # query = open("sql/top_customers.sql").read()

    # df = pd.read_sql(query, engine)
    df = load_dataframe(engine, "top_customers.sql")

    st.subheader("Top Customers")
    st.dataframe(df, use_container_width=True, hide_index=True)


def render_customer_segmentation(engine):

    # query = open("sql/customer_segmentation.sql").read()

    # df = pd.read_sql(query, engine)
    df = load_dataframe(engine, "customer_segmentation.sql")

    st.subheader("Customer Purchase Frequency")
    st.dataframe(df, use_container_width=True, hide_index=True)
