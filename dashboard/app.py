import streamlit as st
import pandas as pd
from db import get_engine
from components.kpi_cards import render_kpis
from components.charts import (
    render_trends,
    render_geo,
    render_category,
    render_status,
)
from components.tables import render_customer_segmentation
from components.insights import render_insights
from filters import build_filters

st.set_page_config("Executive Dashboard", layout="wide")

engine = get_engine()

st.sidebar.header("Filters")

states = pd.read_sql(open("sql/filters/states.sql").read(), engine)

categories = pd.read_sql(open("sql/filters/categories.sql").read(), engine)

selected_states = st.sidebar.multiselect("State", states["customer_state"].tolist())

selected_categories = st.sidebar.multiselect(
    "Category", categories["product_category_name"].tolist()
)
# building filter
where_sql, params = build_filters(
    states=selected_states, categories=selected_categories
)

st.title("Ecommerce Executive Dashboard")

render_kpis(engine, where_sql, params)

st.divider()

render_trends(engine, where_sql, params)

st.divider()

# render_geo(engine)

# st.divider()

# render_category(engine)

# Geography + Categories
col1, col2 = st.columns(2)

with col1:
    render_geo(engine)

with col2:
    render_category(engine)

st.divider()


# Operations + Customers
col1, col2 = st.columns(2)

with col1:
    render_status(engine, where_sql, params)

with col2:
    render_customer_segmentation(engine)

st.divider()

render_insights(engine)
