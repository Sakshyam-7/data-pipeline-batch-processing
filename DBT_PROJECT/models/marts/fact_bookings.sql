{{ config(
    materialized = 'table'
) }}

WITH bookings AS (
    SELECT * FROM {{ ref('stg_bookings') }}
),

listings AS (
    SELECT * FROM {{ ref('stg_listings') }}
)

SELECT
    b.booking_id,
    b.listing_id,
    l.host_id,
    b.booking_date,
    b.booking_status,
    b.nights_booked,
    b.booking_amount,
    b.base_booking_cost,   
    b.cleaning_fee,
    b.service_fee
FROM bookings b
LEFT JOIN listings l 
    ON b.listing_id = l.listing_id