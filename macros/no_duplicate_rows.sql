{% test no_duplicate_rows(model, columns) %}
select
    {{ columns | join(', ') }},
    count(*) as duplicate_count
from {{ model }}
group by {{ columns | join(', ') }}
having duplicate_count > 1
{% endtest %}
