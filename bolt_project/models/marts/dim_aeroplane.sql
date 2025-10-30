with aeroplane as (select * from {{source('bolt_raw_data','aeroplane')}} )
,dim_aeroplane_model as (select * from {{ref('dim_aeroplane_model')}})
select
      airplane_id
     ,airplane_model
     ,a.manufacturer
     ,am.max_seats
     ,max_seats_category
     ,max_distance_category
     ,max_weight
     ,max_distance
     ,engine_type
from aeroplane a
left join dim_aeroplane_model am on a.airplane_model = am.model and a.manufacturer = am.manufacturer