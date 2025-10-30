with customer as (select * from {{source('bolt_raw_data','customer')}})
select 
    customer_id,
    name as full_name,
    email,
    ifnull(customer_group_id,0) as customer_group_id,
    phone_number
from customer
