import pandas as pd
import streamlit as st
from sqlalchemy import create_engine

st.set_page_config(page_title="Ecommerce Analytics", layout="wide")

engine = create_engine(
    "postgresql+psycopg2://postgres:postgres@ecommerce-db:5432/ecommerce"
)

st.title("Ecommerce Analytics Dashboard")

query = """
SELECT *
FROM analytics.mart_product_category
ORDER BY revenue DESC
"""

df = pd.read_sql(query, engine)

st.subheader("Product Category Performance")

st.dataframe(df)

st.bar_chart(df.set_index("product_category_name")["revenue"])
