with aeroplane_model as (select * from {{source('bolt_raw_data','aeroplane_model')}})
,stg__aeroplane_data as (
SELECT 
    manufacturer.value::string AS json_string,
    manufacturer.key::string AS manufacturer,
    model.key::string AS model,
    model.value:max_seats::number AS max_seats,
    model.value:max_weight::number AS max_weight,
    model.value:max_distance::number AS max_distance,
    model.value:engine_type::string AS engine_type
FROM aeroplane_model,
LATERAL FLATTEN(input => variant_col) manufacturer,
LATERAL FLATTEN(input => manufacturer.value) model)
select * from stg__aeroplane_data