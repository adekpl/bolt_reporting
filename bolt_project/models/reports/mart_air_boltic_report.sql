{{ config(materialized='table') }}

-- ==========================================================================
-- Air Boltic Detailed Reporting Mart
-- Combines orders, customers, trips, aircraft, and models for end-to-end analysis
-- ==========================================================================

with fact_orders as (select * from {{ ref('fact_orders') }}),
dim_customers as (select * from {{ ref('dim_customer') }}),
dim_customer_groups as (select * from {{ ref('dim_customer_group') }}),
dim_trip as (select * from {{ ref('dim_trip') }}),
dim_aeroplane_model as (select * from {{ ref('dim_aeroplane_model') }} )

select
    -- identifiers
    t.start_timestamp_utc::date as reporting_date,
    o.order_id,
    o.trip_id,
    o.customer_id,

    -- customer info
    c.full_name as customer_name,
    c.email as customer_email,
    c.phone_number as customer_phone,
    g.type as customer_group_type,
    g.name as customer_group_name,

    -- flight info
    t.origin_city,
    t.destination_city,
    t.origin_city_timezone,
    t.destination_city_timezone,
    t.start_timestamp,
    t.end_timestamp,
    t.start_timestamp_utc,
    t.end_timestamp_utc,
    t.trip_duration_in_minutes,
    t.trip_duration_quality_flag,

    -- aircraft info
    t.airplane_id,
    a.manufacturer,
    a.airplane_model,
    a.max_seats,
    a.max_seats_category,
    a.max_distance,
    a.max_distance_category,
    a.engine_type,

    -- order / revenue info
    o.price_eur,
    o.status as order_status,
 

    -- derived metrics
    --round(t.trip_duration_in_minutes / 60.0, 2) as trip_duration_hours,
    --case when a.max_seats > 0 then round(o.price_eur / a.max_seats, 2)
      --   else null end as revenue_per_seat,

    -- data quality indicators
    case
        when t.trip_duration_quality_flag = 'INVALID' then 'Check duration'
        when t.trip_duration_quality_flag = 'SUSPICIOUS' then 'Check timezone/date'
        else 'OK'
    end as data_quality_note

from fact_orders o
left join dim_customers c on o.customer_id = c.customer_id
left join dim_customer_groups g on c.customer_group_id = g.customer_group_id
left join dim_trip t on o.trip_id = t.trip_id
left join dim_aeroplane a on t.airplane_id = a.airplane_id
