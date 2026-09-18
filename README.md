# GA4 + BigQuery Exploration

Exploring Google Analytics 4 (GA4) event-level data in BigQuery, using Google's public sample ecommerce dataset (`bigquery-public-data.ga4_obfuscated_sample_ecommerce`). Built as a hands-on follow-along of the walkthrough at ga4bigquery.com to practice writing analytical SQL directly against raw event data.

---

## Overview

GA4 exports raw, event-level data to BigQuery rather than pre-aggregated tables, so most analysis starts with unnesting and aggregating events yourself. This project works through that pattern: counting events, tracking daily active users, summarizing purchases and revenue, and ranking products, all with plain SQL.

---

## Dataset

`bigquery-public-data.ga4_obfuscated_sample_ecommerce` is a public, obfuscated GA4 export covering roughly 92 days (Nov 2020 - Jan 2021) of ecommerce event data.

---

## Tools

BigQuery (Standard SQL), run under BigQuery's free Sandbox mode (no billing account needed).

---

## Repository Structure

```
ga4-bigquery-exploration/
|-- queries/
|   |-- 01_events_by_day_and_type.sql   # Events by day and event type
|   |-- 02_daily_distinct_users.sql     # Daily distinct users
|   |-- 03_daily_purchases_and_revenue.sql  # Daily transactions and revenue
|   |-- 04_top_10_items_by_revenue.sql  # Top 10 best-selling items
|-- LICENSE
|-- README.md
```

---

## How to Reproduce

Every query in `queries/` runs for free against Google's public dataset, no download and no billing account required:

1. Open [BigQuery in the Google Cloud Console](https://console.cloud.google.com/bigquery) (sign in with any Google account).
2. If prompted, create a project in Sandbox mode - this is free and does not require a billing account.
3. Open the query editor and paste in the contents of any file from `queries/`, for example `queries/01_events_by_day_and_type.sql`.
4. Click Run. Results appear in the console below the editor.

5. Alternatively, with the [bq command-line tool](https://cloud.google.com/bigquery/docs/bq-command-line-tool) installed and authenticated:

6. ```bash
bq query --use_legacy_sql=false < queries/01_events_by_day_and_type.sql
```

Because the dataset is public, no access request is needed, only a free Google Cloud project.

---

## Queries

**1. Events by day and event type** ( `queries/01_events_by_day_and_type.sql` )
Counts how many times each event type (page_view, scroll, purchase, etc.) fired per day for a 5-day window (Nov 1-5, 2020).

**2. Daily distinct users** ( `queries/02_daily_distinct_users.sql` )
Counts unique users active per day across the full 92-day sample (Nov 2020 - Jan 2021).

**3. Daily purchases and revenue** ( `queries/03_daily_purchases_and_revenue.sql` )
Totals daily transaction counts and purchase revenue from the purchase event.

**4. Top 10 best-selling items by revenue** ( `queries/04_top_10_items_by_revenue.sql` )
Unnests the repeated items field on purchase events to rank products by total revenue.

---

## Notes

All queries run for free under BigQuery's Sandbox mode, no billing account needed. The sample dataset is intentionally obfuscated by Google, so transaction counts and revenue won't perfectly reconcile the way a real store's data would.

Result values (row counts, revenue totals, top products) aren't committed to this repo because they depend on the reader's own BigQuery project and query time window - run the queries yourself using How to Reproduce above to see live numbers in under a minute.

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
