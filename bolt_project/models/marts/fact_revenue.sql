with fact_orders as (select * From {{ref('fact_orders')}})
,dim_trip as (select * from {{ref('dim_trip')}})
select
     ft.end_timestamp_utc::date as reporting_date -- we dont assumption that we recognized revenue after finished fly
    ,sum(price_eur) as total_revenue_in_eur
from fact_orders fo
inner join dim_trip ft on fo.trip_id = ft.trip_id
group by 1