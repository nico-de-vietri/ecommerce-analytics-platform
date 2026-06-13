import streamlit as st
from db import get_engine
from components.kpi_cards import render_kpis
from components.charts import (
    render_trends,
    render_geo,
    render_category,
)

st.set_page_config("Executive Dashboard", layout="wide")

engine = get_engine()

st.title("Ecommerce Executive Dashboard")

render_kpis(engine)

st.divider()
render_trends(engine)

st.divider()
render_geo(engine)

st.divider()
render_category(engine)
