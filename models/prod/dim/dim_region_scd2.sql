-- models/prod/dim_region_scd2.sql
{{ config(materialized='incremental') }}

with base as (
    select
        {{ generate_surrogate_key(['country', 'region', 'state']) }} as region_key, -- Updated macro
        country,
        region,
        state,
        sales,
        current_timestamp() as valid_from,
        null as valid_to
    from {{ ref('usa_sales') }}
)
{% if is_incremental() %}
    , latest as (
        select *
        from {{ this }}
        where valid_to is null
    ),


changes as (
    select
        base.*
    from base
    left join latest
    on base.region_key = latest.region_key
    where base.region != latest.region
),

merged as (
    select * from latest
    where not exists (
        select 1 from changes where latest.region_key = changes.region_key
    )
    union all
    select * from changes
)


select * from merged
{% elif not is_incremental() %}

select * from base

{% endif %}
