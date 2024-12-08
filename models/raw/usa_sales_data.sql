{{ config(materialized='table') }}
{% set selected_regions = ["East", "West", "North", "South"] %}

select country, region, state, 
{% for selected_region in selected_regions %}
sum(case when region = '{{selected_region}}' then sales end ) as {{selected_region}}_sales,
{% endfor %}
sum(sales) as total_sales
from {{ ref('usa_sales') }}
group by 1,2,3 