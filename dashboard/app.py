import streamlit as st
from db import get_engine
from components.kpi_cards import render_kpis
from components.charts import (
    render_trends,
    render_geo,
    render_category,
    render_status,
)
from components.tables import render_top_customers
from components.insights import render_insights

st.set_page_config("Executive Dashboard", layout="wide")

engine = get_engine()

st.title("Ecommerce Executive Dashboard")

render_kpis(engine)

st.divider()

render_trends(engine)

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
    render_status(engine)

with col2:
    render_top_customers(engine)

st.divider()

render_insights(engine)
