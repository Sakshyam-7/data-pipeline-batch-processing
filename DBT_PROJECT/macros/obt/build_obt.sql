{% macro build_obt(config) %}
    {{ validate_obt_config(config) }}
    {{ build_select(config) }}
    {{ build_joins(config) }}
{% endmacro %}