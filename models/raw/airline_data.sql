{% set selected_years = ["2004", "2005"] %}

select *, 
{% for selected_year in selected_years %}
sum(case when selected_years = '{{selected_year}}' then distance end ) as {{selected_year}}_distance,
{% endfor %}
sum(_distance) as total_distance
from {{ ref('airline') }} 