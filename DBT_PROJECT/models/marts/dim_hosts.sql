{{ config(
    materialized = 'table'
) }}

WITH host_snapshot AS (
    SELECT * FROM {{ ref('snp_hosts') }}
)

SELECT
    dbt_scd_id,   
    host_id,
    host_name,
    host_since,
    is_superhost,
    response_rate,
    dbt_valid_from,
    dbt_valid_to,
    CASE WHEN dbt_valid_to IS NULL THEN TRUE ELSE FALSE END AS is_current_record
FROM host_snapshot