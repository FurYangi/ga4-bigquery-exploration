-- Daily transactions and purchase revenue from the purchase event, across the full 92-day sample.

select
  event_date,
  count(distinct case when event_name = 'purchase' then ecommerce.transaction_id end) as transactions,
  round(sum(case when event_name = 'purchase' then ecommerce.purchase_revenue end), 2) as total_revenue
from
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
group by
  event_date
order by
  event_date;
