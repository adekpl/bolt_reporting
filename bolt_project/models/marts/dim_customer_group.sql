with customer_group as (select * from {{source('bolt_raw_data','customer_group')}} )
select
     id as customer_group_id
    ,type
    ,name
    ,registry_number
from customer_group
union 
select
    0 as customer_group_id
    ,'no data' as type
    ,'no data' as name
    ,'no data' as registry_number