-- models/prod/dim_region_scd1.sql
{{ config(materialized='table') }}

select
    country,
    region,
    state,
    now() as last_updated
from {{ ref('usa_sales') }}
group by 1, 2, 3
