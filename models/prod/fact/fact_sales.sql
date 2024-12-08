-- models/prod/fact_sales.sql
{{ config(materialized='table') }}

select
    -- {{ dbt_utils.generate_surrogate_key(['country', 'region', 'state']) }} as location_key,
    -- md5(cast(coalesce(cast(country as CHAR), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(region as CHAR), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(state as CHAR), '_dbt_utils_surrogate_key_null_') as CHAR)) as location_key,
    {{ generate_surrogate_key(['country', 'region', 'state']) }} as location_key,
    country,
    region,
    state,
    sum(sales) as total_sales
from {{ ref('usa_sales') }}
group by 1, 2, 3, 4
