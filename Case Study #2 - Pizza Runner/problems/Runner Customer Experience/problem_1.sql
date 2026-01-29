-- How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
SELECT
    FLOOR((registration_date - DATE '2021-01-01') / 7) + 1 AS week_number,
    COUNT(*) AS runners_signed_up
FROM pizza_runner.runners
GROUP BY week_number
ORDER BY week_number