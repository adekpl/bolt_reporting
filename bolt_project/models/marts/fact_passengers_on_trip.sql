with orders as ( select * from {{source('bolt_raw_data','orders')}})
select
     sha2_hex(concat(customer_id,seat_no,trip_id)) as passenger_id
    ,customer_id
    ,trip_id
    ,seat_no
    ,status as passenger_trip_status
from orders