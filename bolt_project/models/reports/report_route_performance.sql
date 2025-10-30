{{ config(materialized='table') }}

-- Route-level revenue and trip performance

with fact_orders as (select * from {{ ref('fact_orders') }})
,dim_trip as (select * from {{ ref('dim_trip') }})


select
    t.start_timestamp_utc::date as reporting_date,
    t.origin_city,
    t.destination_city,
    count(distinct t.trip_id) as total_trips,
    count(o.customer_id) as number_of_passanger,
    sum(o.price_eur) as total_revenue_eur,
    avg(o.price_eur) as avg_ticket_price_eur,
    round(sum(o.price_eur) / nullif(count(distinct o.trip_id),0),2) as avg_revenue_per_trip,
from fact_orders o
join dim_trip t on o.trip_id = t.trip_id
group by 1,2,3
order by reporting_date desc
