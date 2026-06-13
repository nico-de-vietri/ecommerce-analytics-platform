import streamlit as st
import pandas as pd
from sqlalchemy import create_engine

engine = create_engine(
    "postgresql+psycopg2://postgres:postgres@ecommerce-db:5432/ecommerce"
)

st.set_page_config(page_title="Ecommerce Executive Dashboard", layout="wide")

st.title("Ecommerce Executive Dashboard")


kpi = """
    SELECT
    COUNT(DISTINCT c.customer_unique_id) AS customers,
    COUNT(DISTINCT fo.order_id) AS orders,
    SUM(fo.payment_value) AS revenue,
    ROUND(AVG(fo.payment_value), 2) AS avg_order_value
FROM analytics.fact_orders fo
JOIN staging.customers c
    ON fo.customer_id = c.customer_id;
"""

df = pd.read_sql(kpi, engine)

col1, col2, col3, col4 = st.columns(4)

col1.metric("Customers", f"{df['customers'][0]:,}")
col2.metric("Orders", f"{df['orders'][0]:,}")
col3.metric("Revenue", f"${df['revenue'][0]:,.0f}")
col4.metric("Avg Order Value", f"${df['avg_order_value'][0]:,.2f}")


trend = """
SELECT
    DATE_TRUNC('month', fo.order_purchase_timestamp) AS month,
    SUM(fo.payment_value) AS revenue,
    COUNT(DISTINCT c.customer_unique_id) AS customers
FROM analytics.fact_orders fo
JOIN staging.customers c
    ON fo.customer_id = c.customer_id
GROUP BY 1
ORDER BY 1;

"""

df = pd.read_sql(trend, engine)

st.subheader("Revenue & Customers Trend")
st.line_chart(df.set_index("month")[["revenue", "customers"]])

geo = pd.read_sql(
    """
SELECT *
FROM analytics.mart_geography
ORDER BY revenue DESC
""",
    engine,
)

st.subheader("Revenue by State")
st.bar_chart(geo.set_index("customer_state")["revenue"])


prod = pd.read_sql(
    """
SELECT *
FROM analytics.mart_product_category
ORDER BY revenue DESC
LIMIT 10
""",
    engine,
)

st.subheader("Top Product Categories")
st.bar_chart(prod.set_index("product_category_name")["revenue"])

cust = pd.read_sql(
    """
SELECT total_orders, COUNT(*) AS customers
FROM analytics.mart_customers
GROUP BY total_orders
ORDER BY total_orders;
""",
    engine,
)

st.subheader("Customer Purchase Frequency")
st.bar_chart(cust.set_index("total_orders")["customers"])
