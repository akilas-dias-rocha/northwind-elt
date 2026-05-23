-- ================================================================================
-- CREATING CATALOGS AND SCHEMES - NORTHWIND TRADERS   
-- ================================================================================
-- Run this script ONCE to provision the complete framework.
-- ================================================================================

-- 1. RAW CATALOG - Ingestion of raw data
-- ================================================================================
CREATE CATALOG IF NOT EXISTS northwind_raw_data
COMMENT 'Raw data';

CREATE SCHEMA IF NOT EXISTS northwind_raw_data.source_sql_db
COMMENT 'Source - SQLite database';

CREATE VOLUME IF NOT EXISTS northwind_raw_data.source_sql_db.raw_files
COMMENT "Raw files"

-- ================================================================================
-- 2. DEVELOPMENT CATALOG - Individual dev workspace
-- ================================================================================
CREATE CATALOG IF NOT EXISTS northwind_dev
COMMENT 'Individual workspace for development with dbt';

-- ================================================================================
-- 3. PRODUCTION CATALOG - Production environment (validated models)
-- ================================================================================
CREATE CATALOG IF NOT EXISTS northwind_prod
COMMENT 'Production - Validated dbt models delivered to the client';

CREATE SCHEMA IF NOT EXISTS northwind_prod.staging
COMMENT 'Clean and standardized data';

CREATE SCHEMA IF NOT EXISTS northwind_prod.intermediate
COMMENT 'Enriched data and applied business rules';

CREATE SCHEMA IF NOT EXISTS northwind_prod.marts
COMMENT 'Aggregated and ready-to-use data (BI/Analytics/ML)';

-- ================================================================================
-- VERIFICATION - List created catalogs
-- ================================================================================
SHOW CATALOGS;
