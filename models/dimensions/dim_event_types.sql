/*setting the dimension table to be loaded incrementally*/
{{ 
    config(
        materialized='incremental'
    )
}}
-- get all the events from the 
WITH event_types AS (
    SELECT
        *
    FROM {{ ref('all_events')}}
),

already_loaded AS (
    SELECT
        event_name
    FROM weather_data.dim_event_types
),

difference AS (
    SELECT
        event_type
    FROM event_types
    WHERE event_type NOT IN (SELECT event_name FROM already_loaded)
)

SELECT 
    nextval('weather_data.seq_dim_event_types') AS event_id, 
    event_type AS event_name,
    NOW() AS date_loaded
FROM difference