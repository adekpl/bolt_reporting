with orders as ( select * from {{source('bolt_raw_data','orders')}})
select
     order_id
    ,customer_id
    ,price_eur
    ,status -- trip status
    ,trip_id
from orders