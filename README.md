# Northwind Traders — End-to-End ELT Pipeline

![Databricks](https://img.shields.io/badge/Databricks-FF3621?style=for-the-badge&logo=databricks&logoColor=white)
![Apache Spark](https://img.shields.io/badge/PySpark-E25A1C?style=for-the-badge&logo=apachespark&logoColor=white)
![dbt](https://img.shields.io/badge/dbt-FF694B?style=for-the-badge&logo=dbt&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-4479A1?style=for-the-badge&logo=sqlite&logoColor=white)

An end-to-end ELT pipeline built on the Northwind Traders database, covering data extraction, loading, transformation, and visualization through a final dashboard.

---

## Table of Contents

- [Northwind Traders — End-to-End ELT Pipeline](#northwind-traders--end-to-end-elt-pipeline)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Dataset](#dataset)
  - [Tech Stack](#tech-stack)
  - [Architecture](#architecture)
  - [Pipeline](#pipeline)
    - [Extraction \& Loading](#extraction--loading)
    - [Transformation](#transformation)
      - [Staging](#staging)
      - [Intermediate](#intermediate)
      - [Marts](#marts)
  - [dbt Models](#dbt-models)
    - [Staging](#staging-1)
    - [Intermediate](#intermediate-1)
    - [Marts](#marts-1)
  - [Business Rules](#business-rules)
  - [Project Structure](#project-structure)
  - [Dashboard](#dashboard)

---

## Overview

This project implements a fully functional ELT (Extract, Load, Transform) data pipeline using the Northwind Traders database as the data source. The pipeline ingests raw data into Databricks, transforms it following the Medallion Architecture using dbt, and delivers analytical models ready for dashboard consumption in Power BI.

---

## Dataset

The **Northwind Traders** database contains sales data from a fictional company that imports and exports specialty foods worldwide. It covers the following business domains:

![ERD](docs/northwind-ERD.png)

---

## Tech Stack

| Tool | Purpose |
|---|---|
| **Databricks** | Cloud data platform and compute engine |
| **PySpark** | Raw data ingestion and Delta Table creation |
| **dbt** | Data transformation and modeling |
| **SQL** | Querying and business logic |
| **Python** | Supporting scripts and automation |
| **Power BI** | Dashboard and data visualization |

---

## Architecture

The project follows the **Medallion Architecture**, organized across three transformation layers inside Databricks:

```
northwind_raw_data          # Raw ingestion layer
└── source_sql_db

northwind_dev               # Development environment
└── dev_akilas_rocha

northwind_prod              # Production environment
├── staging                 # Cleaned and typed source tables
├── intermediate            # Business logic and complex joins
└── marts                   # Fact and dimension tables (Star Schema)
```

---

## Pipeline

### Extraction & Loading

The source data is provided as a **SQLite file**, which is manually uploaded to a **Databricks Volume**. From there, a **PySpark script** reads the files and writes them to the `northwind_raw_data.source_sql_db` schema as **Delta Tables**.

```
SQLite file
    └── Manual upload to Databricks Volume
            └── PySpark ingestion script
                    └── Delta Tables → northwind_raw_data.source_sql_db
```

### Transformation

Transformations are handled by **dbt**, following the three layers of the Medallion Architecture:

#### Staging
- Standardizes column naming for better readability
- Applies `CAST` to enforce proper data types
- One model per source table — no joins at this layer

#### Intermediate
- Prepares data for the Marts layer
- Handles complex multi-table joins
- Applies business rules and derived calculations

#### Marts
- Contains **Fact** and **Dimension** tables modeled as a **Star Schema**
- Designed to serve analytical queries and dashboard consumption

```
Raw (Delta Tables)
    └── Staging       
        └── Intermediate
            └── Marts
```

---

## dbt Models

### Staging

| Model | Description |
|---|---|
| `stg__northwind_category` | Product categories |
| `stg__northwind_customer` | Customer records |
| `stg__northwind_customer_customer_demo` | Customer demographic associations |
| `stg__northwind_customer_demographic` | Customer demographic segments |
| `stg__northwind_employee` | Employee records |
| `stg__northwind_employee_territory` | Employee-territory assignments |
| `stg__northwind_order` | Sales orders |
| `stg__northwind_order_detail` | Order line items |
| `stg__northwind_product` | Product catalog |
| `stg__northwind_region` | Sales regions |
| `stg__northwind_shipper` | Shipping carriers |
| `stg__northwind_supplier` | Suppliers |
| `stg__northwind_territory` | Territory definitions |

### Intermediate

| Model | Description |
|---|---|
| `int__order_detail` | Order details enriched with business rules and joins |
| `int__product` | Product data with inventory and pricing validations |
| `int__inventory_management` | Inventory metrics and reconciliation logic |

### Marts

| Model | Type | Description |
|---|---|---|
| `fct__order` | Fact | Core sales fact table |
| `dim__customer` | Dimension | Customer dimension |
| `dim__employee` | Dimension | Employee dimension |
| `dim__product` | Dimension | Product dimension |
| `dim__shipper` | Dimension | Shipper dimension |
| `dim__supplier` | Dimension | Supplier dimension |
| `dim__territory` | Dimension | Territory dimension |
| `dim__date` | Dimension | Date dimension |

---

## Business Rules

Data quality tests are enforced through dbt to ensure the integrity of the pipeline. The following rules are applied:

| Table | Rule |
|---|---|
| `order_detail` | The `discount` column must be between `0` and `1` — a discount greater than 100% is invalid |
| `order_detail` | The `quantity` of products in a purchase order must be greater than zero |
| `product` | The `unit_price` of a product cannot be zero — this indicates a registration error |
| `product` | The `units_in_stock` value cannot be negative — this indicates a stock reconciliation error |

---

## Project Structure

```
northwind-elt/
├── dbt/                              # dbt project (models, tests, configs)
│   └── models/
│       ├── staging/                  # stg_* models — typed and renamed source tables
│       ├── intermediate/             # int_* models — joins and business logic
│       └── marts/                    # fct_* and dim_* models — Star Schema
├── northwind_data/
│   └── Northwind_db.sqlite           # Source SQLite database
├── notebooks/
│   └── ingestion_raw_tables.ipynb    # PySpark ingestion notebook
├── setup/
│   ├── setup_catalogs_squemas.sql    # Catalog and schema setup
│   └── setup_secrets_scope.ipynb     # Databricks secrets configuration
├── example.env                       # Environment variables template
├── .gitignore
├── requirements.txt
└── README.md
```

---

## Dashboard

The final layer of the pipeline is a **Power BI** dashboard connected to the Marts layer. It consumes the Star Schema models to deliver business insights on sales performance, customer behavior, product trends, and operational metrics.