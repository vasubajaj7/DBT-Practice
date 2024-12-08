SELECT *
FROM {{ ref('usa_sales') }}
{{ generate_filter(var("report_region", ["West"])) }}
