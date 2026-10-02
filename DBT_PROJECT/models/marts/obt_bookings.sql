{{ config(
    materialized = 'table',
    schema = 'gold'
) }}

{% set config = obt_sales_config() %}

{{ build_obt(config) }}