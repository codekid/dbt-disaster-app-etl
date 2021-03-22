SELECT
    DISTINCT event_type
FROM public.st_storm_data
UNION
SELECT 'Unkown'