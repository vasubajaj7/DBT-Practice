{% set selected_countries = ["USR", "US"] %}

select *, 
{% for selected_country in selected_countries %}
case when country_code = '{{selected_country}}' then 'Indian Ally' end as {{selected_country}}_amount,
{% endfor %}
row_number() over(order by country_code) as rid
from {{ ref('countries') }} 
