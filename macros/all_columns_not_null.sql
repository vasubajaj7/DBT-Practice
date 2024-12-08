{% test all_columns_not_null(model, columns) %}
select
    {{ columns | map(attribute='column') | join(', ') }},
    count(*) as num_nulls
from {{ model }}
where
    {% for column in columns %}
        {{ column }} is null
        {% if not loop.last %} or {% endif %}
    {% endfor %}
group by {{ columns | map(attribute='column') | join(', ') }}
having num_nulls > 0
{% endtest %}
