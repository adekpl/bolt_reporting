{{ config(materialized='table') }}

select *
from values
  ('Toronto', 'America/Toronto'),
  ('Mumbai', 'Asia/Kolkata'),
  ('Berlin', 'Europe/Berlin'),
  ('Paris', 'Europe/Paris'),
  ('Tokyo', 'Asia/Tokyo'),
  ('Frankfurt', 'Europe/Berlin'),
  ('Los Angeles', 'America/Los_Angeles'),
  ('Hong Kong', 'Asia/Hong_Kong'),
  ('Amsterdam', 'Europe/Amsterdam'),
  ('Cape Town', 'Africa/Johannesburg'),
  ('Vancouver', 'America/Vancouver'),
  ('Sydney', 'Australia/Sydney'),
  ('Dubai', 'Asia/Dubai'),
  ('Sao Paulo', 'America/Sao_Paulo'),
  ('New York', 'America/New_York'),
  ('Rio de Janeiro', 'America/Sao_Paulo'),
  ('Moscow', 'Europe/Moscow'),
  ('Beijing', 'Asia/Shanghai'),
  ('Bangkok', 'Asia/Bangkok'),
  ('Melbourne', 'Australia/Melbourne'),
  ('Auckland', 'Pacific/Auckland'),
  ('Miami', 'America/New_York'),
  ('Johannesburg', 'Africa/Johannesburg'),
  ('Chicago', 'America/Chicago'),
  ('Singapore', 'Asia/Singapore'),
  ('London', 'Europe/London'),
  ('Madrid', 'Europe/Madrid'),
  ('San Francisco', 'America/Los_Angeles'),
  ('Mexico City', 'America/Mexico_City')
as city_tz(city, iana_tz)