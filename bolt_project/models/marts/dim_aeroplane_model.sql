with stg_aeroplane_model as (select * from {{ref('stg_aeroplane_model')}})
select
    sha2_hex(concat(manufacturer,model)) as aeroplane_model_id,
    manufacturer,
    model,
    max_seats, --cover capacity coverage
    case 
        when max_seats <= 10 then '1-10'
        when max_seats <= 20 then '11-20'
        when max_seats <= 100 then '21-100'
        when max_seats <= 200 then '101-200'
        when max_seats > 200 then '201+'
    end as max_seats_category,
    case 
        when max_distance <= 2000 then '1-2000'
        when max_distance <= 3000 then '2001-3000'
        when max_distance <= 4000 then '3001-4000'
        when max_distance <= 6000 then '4001-6000'
        when max_distance > 6000 then '6000+'
    end as max_distance_category,
    max_weight,
    max_distance,
    engine_type
from stg_aeroplane_model