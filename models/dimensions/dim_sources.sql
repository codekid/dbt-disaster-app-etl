/*setting the dimension table to be loaded incrementally*/
{{ 
    config(
        materialized='incremental'
    )
}}

WITH sources AS (
    SELECT
        *
    FROM {{ ref('all_sources') }}
),

already_loaded AS (
    SELECT
        source_name
    FROM weather_data.dim_sources
),

difference AS (
    SELECT
        source
    FROM sources
    WHERE source NOT IN (SELECT source_name FROM already_loaded)
)

SELECT
    CASE
        WHEN source = 'Source Not Found' THEN -1
        ELSE nextval('weather_data.seq_dim_sources')
    END AS source_id,
    source AS source_name,
    NOW() AS date_loaded
FROM difference