-- Daily distinct users across the full 92-day sample (Nov 2020 - Jan 2021).

select
  event_date,
  count(distinct user_pseudo_id) as total_users
from
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
group by
  event_date
order by
  event_date;
