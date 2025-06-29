SELECT ROUND(AVG(LAT_N), 4) AS MEDIAN_LAT_N
FROM (
    SELECT LAT_N
    FROM (
        SELECT LAT_N, @rownum := @rownum + 1 AS rn
        FROM STATION, (SELECT @rownum := 0) r
        ORDER BY LAT_N
    ) AS sorted
    WHERE rn IN (
        FLOOR((@rowcount + 1) / 2),
        CEIL((@rowcount + 1) / 2)
    )
) AS median_calc,
(SELECT @rowcount := COUNT(*) FROM STATION) AS counts;
