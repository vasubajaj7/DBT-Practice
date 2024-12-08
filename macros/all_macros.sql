{% macro generate_filter(regions) %}
WHERE region = ( {% for region in  regions %}'{{ region }}'{% if not loop.last %}, {% endif %} {% if loop.last %} ) {% endif %}
{% endfor %}
{% endmacro %}