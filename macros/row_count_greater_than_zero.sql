{% macro row_count_greater_than_zero(model, columns) %}

with a as (select
    count(*) as count
from {{ model }}
) 
select case when count=0 then True else False from a

{% endmacro %}