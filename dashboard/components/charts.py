import streamlit as st
import pandas as pd
import altair as alt


def render_trends(engine):
    query = open("sql/revenue_trend.sql").read()
    df = pd.read_sql(query, engine)

    df["month"] = pd.to_datetime(df["month"])
    df = df.sort_values("month")

    col1, col2 = st.columns(2)

    with col1:
        st.subheader("Revenue Trend")
        st.altair_chart(
            alt.Chart(df).mark_line().encode(x="month:T", y="revenue:Q"),
            use_container_width=True,
        )

    with col2:
        st.subheader("AOV Trend")
        st.altair_chart(
            alt.Chart(df).mark_line().encode(x="month:T", y="aov:Q"),
            use_container_width=True,
        )


def render_geo(engine):
    df = pd.read_sql(open("sql/geography.sql").read(), engine)
    st.subheader("Revenue by State")
    st.bar_chart(df.set_index("customer_state")["revenue"])


def render_category(engine):
    df = pd.read_sql(open("sql/category.sql").read(), engine)
    st.subheader("Revenue by Category")
    st.bar_chart(df.set_index("product_category_name")["revenue"])


def render_top_categories(engine):
    df = pd.read_sql(open("sql/top_products_categories.sql").read(), engine)

    st.subheader("Top 10 Product Categories by Revenue")

    st.bar_chart(df.set_index("product_category_name")["revenue"])


def render_status(engine):

    df = pd.read_sql(open("sql/order_status.sql").read(), engine)

    st.subheader("Order Status Distribution")
    st.bar_chart(df.set_index("order_status"))
