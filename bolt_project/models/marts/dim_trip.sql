with trip as (select * from {{source('bolt_raw_data','trip')}} )
,dim_timezones as (select * from {{ref('dim_timezones')}})
,trip_with_timezones as (
    select 
         t.trip_id
        ,t.origin_city
        ,odt.iana_tz as origin_city_timezone
        ,t.destination_city
        ,ddt.iana_tz as destination_city_timezone
        ,t.airplane_id
        ,t.start_timestamp
        ,t.end_timestamp
        ,convert_timezone(odt.iana_tz, 'UTC', t.start_timestamp) as start_timestamp_utc
        ,convert_timezone(ddt.iana_tz, 'UTC', t.end_timestamp)   as end_timestamp_utc
    from trip t
    left join dim_timezones odt on t.origin_city = odt.city
    left join dim_timezones ddt on t.destination_city = ddt.city
)

,final as (
    select
        trip_id,
        origin_city,
        origin_city_timezone,
        destination_city,
        destination_city_timezone,
        airplane_id,
        start_timestamp,
        end_timestamp,
        start_timestamp_utc,
        end_timestamp_utc,
        case 
            when end_timestamp_utc < start_timestamp_utc then
                datediff(minute, start_timestamp_utc, dateadd(day, 1, end_timestamp_utc))
            else
                datediff(minute, start_timestamp_utc, end_timestamp_utc)
        end as trip_duration_in_minutes,
        case 
            when trip_duration_in_minutes < 15 then 'INVALID'
            when trip_duration_in_minutes > 24*60 then 'SUSPICIOUS'
        else 'VALID' end as trip_duration_quality_flag
    from trip_with_timezones
)

select * from final