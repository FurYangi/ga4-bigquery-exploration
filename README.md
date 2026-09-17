# GA4 + BigQuery Exploration

Exploring Google Analytics 4 (GA4) event-level data in BigQuery, using Google's public sample ecommerce dataset (`bigquery-public-data.ga4_obfuscated_sample_ecommerce`). Built as a hands-on follow-along of the walkthrough at ga4bigquery.com to practice writing analytical SQL directly against raw event data.

## Overview

GA4 exports raw, event-level data to BigQuery rather than pre-aggregated tables, so most analysis starts with unnesting and aggregating events yourself. This project works through that pattern: counting events, tracking daily active users, summarizing purchases and revenue, and ranking products, all with plain SQL.

## Dataset

`bigquery-public-data.ga4_obfuscated_sample_ecommerce` is a public, obfuscated GA4 export covering roughly 92 days (Nov 2020 - Jan 2021) of ecommerce event data.

## Tools

BigQuery (Standard SQL), run under BigQuery's free Sandbox mode.

## Queries

### 1. Events by day and event type

```sql
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
  event_date, event_count DESC
```

Counts how many times each event type (page_view, scroll, purchase, etc.) fired per day for a 5-day window (Nov 1-5, 2020).

### 2. Daily distinct users

```sql
select
  event_date,
  count(distinct user_pseudo_id) as total_users
from
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
group by
  event_date
order by
  event_date
```

Counts unique users active per day across the full 92-day sample (Nov 2020 - Jan 2021).

### 3. Daily purchases and revenue

```sql
select
  event_date,
  count(distinct case when event_name = 'purchase' then ecommerce.transaction_id end) as transactions,
  round(sum(case when event_name = 'purchase' then ecommerce.purchase_revenue end), 2) as total_revenue
from
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
group by
  event_date
order by
  event_date
```

Totals daily transaction counts and purchase revenue from the purchase event.

### 4. Top 10 best-selling items by revenue

```sql
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
limit 10
```

Unnests the repeated items field on purchase events to rank products by total revenue.

## Notes

All queries ran for free under BigQuery's Sandbox mode, no billing account needed. The sample dataset is intentionally obfuscated by Google, so transaction counts and revenue won't perfectly reconcile the way a real store's data would.
