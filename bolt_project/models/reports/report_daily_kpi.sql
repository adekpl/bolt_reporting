{{ config(materialized='table') }}

-- Daily KPI summary for Air Boltic

with fact_orders as ( select * from {{ ref('fact_orders') }}),
dim_trip as ( select * from {{ ref('dim_trip') }}),
dim_customer as ( select * from {{ ref('dim_customer') }})

select
    date_trunc('day', t.start_timestamp_utc) as reporting_date,
    count(distinct c.customer_id) as daily_active_users,
    count(distinct t.trip_id) as daily_distinct_trips,
    count(order_id) as daily_orders,
    sum(o.price_eur) as total_revenue_eur,
    --avg(o.price_eur) as avg_ticket_price_eur,
    count_if(o.status = 'Cancelled')::float / nullif(count(*),0) * 100 as cancellation_rate_pct,
    round(sum(case when t.trip_duration_quality_flag = 'VALID' then 1 else 0 end)::float / nullif(count(*),0) * 100,2) as valid_trip_ratio_pct
from fact_orders o
left join dim_trip t on o.trip_id = t.trip_id
left join dim_customer c on c.customer_id = o.customer_id
group by 1
order by 1
