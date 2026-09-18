-- Top 10 best-selling items by revenue, unnesting the repeated items field on purchase events.

select
  item.item_name,
  sum(item.quantity) as total_quantity,
  round(sum(item.item_revenue), 2) as total_revenue
from
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,
  unnest(items) as item
where
  event_name = 'purchase'
group by
  item.item_name
order by
  total_revenue desc
limit 10;
