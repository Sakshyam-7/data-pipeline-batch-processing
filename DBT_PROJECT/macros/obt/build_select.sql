{% macro build_select(config) %}
SELECT
    {% set ns = namespace(first=true) %}
    
    {# 1. Base columns #}
    {% for column in config.base.columns %}
        {% if not ns.first %}, {% endif %}
        {{ config.base.alias }}.{{ column }}
        {% set ns.first = false %}
    {% endfor %}

    {# 2. Join columns #}
    {% if config.joins is defined %}
        {% for join in config.joins %}
            {% for column in join.columns %}
                , {{ join.alias }}.{{ column.name }}
                {% if column.rename is defined %} as {{ column.rename }}{% endif %}
            {% endfor %}
        {% endfor %}
    {% endif %}

    {# 3. Derived columns #}
    {% if config.derived is defined %}
        {% for derived in config.derived %}
            , {{ derived.expr }} as {{ derived.name }}
        {% endfor %}
    {% endif %}
{% endmacro %}