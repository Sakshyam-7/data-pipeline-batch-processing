{% macro multiply_column(column1, column2, col_name) %}
    ({{ column1 }} * {{ column2 }}) AS {{ col_name }}
{% endmacro %}