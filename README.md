# Ecommerce Analytics Platform

An end-to-end analytics engineering project that transforms raw ecommerce transactions into an executive Business Intelligence dashboard using PostgreSQL, SQL, Docker, Python, and Streamlit.

The project demonstrates a complete analytical workflow—from raw CSV ingestion to dimensional modeling, data quality validation, and interactive reporting.

---

# Overview

Operational databases are designed to support transactions, not analytical reporting.

This project implements a lightweight analytics platform that separates ingestion, transformation, validation, and reporting into modular layers, following common data warehousing practices.

Pipeline flow:

```
Raw CSV Files
        │
        ▼
 Staging Tables
        │
        ▼
analytics.fact_orders
        │
        ▼
 Analytical Data Marts
        │
        ▼
Executive BI Dashboard
```

---

# Features

## ELT Pipeline

* Automated SQL pipeline
* Modular SQL execution
* Dockerized PostgreSQL environment
* Data quality validation
* Warehouse-style architecture
* Reproducible end-to-end execution

## Data Warehouse

The warehouse is organized into logical layers:

### Staging

Raw ecommerce data is loaded into normalized staging tables.

### Fact Table

`analytics.fact_orders`

Central fact table containing:

* Orders
* Customers
* Revenue
* Freight
* Product category
* Order lifecycle
* Purchase timestamps

### Data Marts

* Geography
* Product Category
* Customer
* Executive Summary

These marts provide simplified datasets optimized for dashboard queries.

---

# Executive Dashboard

The Streamlit dashboard provides interactive business reporting with dynamic SQL filtering.

### Executive KPIs

* Revenue
* Orders
* Customers
* Average Order Value
* Delivery Success Rate

### Business Visualizations

* Revenue Trend
* Average Order Value Trend
* Revenue by State
* Revenue by Product Category
* Order Status Distribution
* Top Customers
* Executive Insights

### Interactive Filters

* Customer State
* Product Category

All dashboard queries are parameterized and executed directly against PostgreSQL.

---

# Repository Structure

```
.
├── dashboard/
│   ├── app.py
│   ├── components/
│   ├── sql/
│   └── utils/
│
├── sql/
│   ├── 01_setup/
│   ├── 02_staging/
│   ├── 03_load/
│   ├── 04_quality_check/
│   └── 05_marts/
│
├── data/
├── run_pipeline.sh
├── docker-compose.yml
└── README.md
```

---

# Technology Stack

| Area             | Technology              |
| ---------------- | ----------------------- |
| Database         | PostgreSQL              |
| Query Language   | SQL                     |
| Backend          | Python                  |
| Data Access      | SQLAlchemy              |
| Analytics        | Pandas                  |
| Dashboard        | Streamlit               |
| Visualization    | Altair                  |
| Containerization | Docker & Docker Compose |

---

# Running the Project

## Start PostgreSQL and pgAdmin

```bash
docker compose up --build
```

## Execute the ELT pipeline

```bash
./run_pipeline.sh
```

## Launch the dashboard

```bash
streamlit run dashboard/app.py
```

---

# Dashboard Preview

*Add dashboard screenshots here.*

Suggested screenshots:

* Executive Overview
* KPI Cards
* Revenue Trends
* Interactive Filtering
* Executive Insights

---

# Design Decisions

### Why a Fact Table?

The dashboard reads from a centralized fact table rather than querying raw transactional tables. This simplifies reporting queries and reduces repeated business logic.

### Why Separate Data Marts?

Data marts provide business-oriented datasets optimized for visualization while keeping dashboard SQL concise and maintainable.

### Why SQL Transformations?

Business transformations remain inside PostgreSQL, making the analytical logic transparent, reusable, and independent of the visualization layer.

### Why Modular Dashboard Components?

Charts, KPIs, insights, and SQL loading are separated into reusable modules, improving maintainability as the dashboard grows.

---

# Future Improvements

* Incremental data loading
* Automated orchestration
* Cloud deployment
* Interactive geographic maps
* Unit tests
* CI/CD pipeline
* Role-based dashboards

---

# Key Learnings

This project provided practical experience in:

* Relational data modeling
* ELT pipeline design
* PostgreSQL analytics
* SQL optimization
* Data quality validation
* Executive dashboard development
* Dockerized analytics environments
* Modular Python application design

---

# Dataset

This project uses the publicly available **Brazilian Olist E-commerce Dataset**, which contains anonymized ecommerce transactions, customer information, products, payments, and order history.

---

# License

This repository is intended for educational and portfolio purposes.

