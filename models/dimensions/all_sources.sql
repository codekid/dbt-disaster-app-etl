SELECT DISTINCT source
FROM st_storm_data
UNION
SELECT 'Source Not Found'
