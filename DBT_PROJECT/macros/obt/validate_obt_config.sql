{% macro validate_obt_config(config) %}

{% if config.base is not defined %}
    {{ exceptions.raise_compiler_error("OBT config missing 'base'") }}
{% endif %}

{% if config.base.model is not defined %}
    {{ exceptions.raise_compiler_error("OBT base missing 'model'") }}
{% endif %}

{% if config.base.columns is not defined %}
    {{ exceptions.raise_compiler_error("OBT base missing 'columns'") }}
{% endif %}

{% if config.joins is defined %}
    {% for join in config.joins %}
        {% if join.model is not defined %}
            {{ exceptions.raise_compiler_error("Join missing 'model'") }}
        {% endif %}
        {% if join.on is not defined %}
            {{ exceptions.raise_compiler_error("Join on " ~ join.model ~ " missing 'on'") }}
        {% endif %}
        {% if join.columns is not defined %}
            {{ exceptions.raise_compiler_error("Join on " ~ join.model ~ " missing 'columns'") }}
        {% endif %}
    {% endfor %}
{% endif %}

{% endmacro %}