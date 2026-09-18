-- Events by day and event type, for a 5-day window (Nov 1-5, 2020).
-- Counts how many times each event type (page_view, scroll, purchase, etc.) fired per day.

SELECT
  event_date,
  event_name,
  COUNT(*) AS event_count
FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE
  _TABLE_SUFFIX BETWEEN '20201101' AND '20201105'
GROUP BY
  event_date, event_name
ORDER BY
  event_date, event_count DESC;
