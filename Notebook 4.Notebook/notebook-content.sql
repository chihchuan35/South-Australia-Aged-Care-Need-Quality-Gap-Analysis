-- Fabric notebook source

-- METADATA ********************

-- META {
-- META   "kernel_info": {
-- META     "name": "synapse_pyspark"
-- META   },
-- META   "dependencies": {
-- META     "lakehouse": {
-- META       "default_lakehouse": "b79ab203-1467-49d3-8cee-b1167b01224a",
-- META       "default_lakehouse_name": "MLV_Demo_",
-- META       "default_lakehouse_workspace_id": "d14c2a4b-ab69-4b61-8f1b-eb0217100713",
-- META       "known_lakehouses": [
-- META         {
-- META           "id": "b79ab203-1467-49d3-8cee-b1167b01224a"
-- META         }
-- META       ]
-- META     }
-- META   }
-- META }

-- MARKDOWN ********************

-- # Create materialized lake views 
-- 1. Use this notebook to create materialized lake views. 
-- 2. Select **Run all** to run the notebook. 
-- 3. When the notebook run is completed, return to your lakehouse and refresh your materialized lake views graph. 


-- CELL ********************

CREATE SCHEMA IF NOT EXISTS bronze;
CREATE SCHEMA IF NOT EXISTS silver;
CREATE SCHEMA IF NOT EXISTS gold;

CREATE TABLE IF NOT EXISTS bronze.services (service_id INT, region STRING, overall_rating INT);
INSERT INTO bronze.services VALUES
 (1,'Metropolitan East',4),(2,'Metropolitan East',3),
 (3,'Riverland',3),(4,'Riverland',NULL),(5,'Mid North',5);

-- METADATA ********************

-- META {
-- META   "language": "sparksql",
-- META   "language_group": "synapse_pyspark"
-- META }

-- CELL ********************

CREATE MATERIALIZED LAKE VIEW IF NOT EXISTS silver.services_clean
( CONSTRAINT rating_not_null CHECK (overall_rating IS NOT NULL) ON MISMATCH DROP )
COMMENT "Rated services only (null ratings dropped)"
AS SELECT service_id, region, overall_rating FROM bronze.services;

-- METADATA ********************

-- META {
-- META   "language": "sparksql",
-- META   "language_group": "synapse_pyspark"
-- META }

-- CELL ********************

SELECT * FROM silver.services_clean;

-- METADATA ********************

-- META {
-- META   "language": "sparksql",
-- META   "language_group": "synapse_pyspark"
-- META }

-- CELL ********************

CREATE MATERIALIZED LAKE VIEW IF NOT EXISTS gold.avg_rating_by_region
COMMENT "Average overall rating per region"
AS SELECT region, ROUND(AVG(overall_rating),2) AS avg_rating, COUNT(*) AS n_services
   FROM silver.services_clean GROUP BY region;

-- METADATA ********************

-- META {
-- META   "language": "sparksql",
-- META   "language_group": "synapse_pyspark"
-- META }

-- CELL ********************

SELECT * FROM gold.avg_rating_by_region ORDER BY avg_rating DESC;

-- METADATA ********************

-- META {
-- META   "language": "sparksql",
-- META   "language_group": "synapse_pyspark"
-- META }
