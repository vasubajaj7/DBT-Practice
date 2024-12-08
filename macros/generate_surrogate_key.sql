{% macro generate_surrogate_key(columns) %}
md5(
    cast(
        concat(
            {% for column in columns %}
                coalesce(cast({{ column }} as CHAR), '_dbt_utils_surrogate_key_null_')
                {% if not loop.last %}, '-', {% endif %}
            {% endfor %}
        )
        as CHAR
    )
)
{% endmacro %}
