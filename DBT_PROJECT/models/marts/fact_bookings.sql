{{ config(
    materialized = 'incremental',
    unique_key = 'booking_id'
) }}

WITH bookings AS (
    SELECT * FROM {{ ref('stg_bookings') }}
    
    {% if is_incremental() %}
        WHERE created_at > (SELECT max(created_at) FROM {{ this }})
    {% endif %}
),

listings AS (
    SELECT * FROM {{ ref('stg_listings') }}
),

hosts AS (
    SELECT * FROM {{ ref('snp_hosts') }} 
)

SELECT
    b.booking_id,
    b.listing_id,
    l.host_id,
    h.dbt_scd_id AS host_snapshot_id, 
    b.booking_date,
    b.booking_status,
    b.nights_booked,
    b.booking_amount,
    b.base_booking_cost,   
    b.cleaning_fee,
    b.service_fee,
    b.created_at
FROM bookings b
LEFT JOIN listings l 
    ON b.listing_id = l.listing_id
LEFT JOIN hosts h
    ON l.host_id = h.host_id
    AND b.booking_date >= h.dbt_valid_from 
    AND (b.booking_date < h.dbt_valid_to OR h.dbt_valid_to IS NULL)