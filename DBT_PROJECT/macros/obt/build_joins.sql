{% macro build_joins(config) %}
from {{ ref(config.base.model) }} as {{ config.base.alias }}

{% for join in config.joins %}
    {{ join.type | upper }} JOIN {{ ref(join.model) }} as {{ join.alias }}
        ON {{ join.on }}
{% endfor %}

{% endmacro %}