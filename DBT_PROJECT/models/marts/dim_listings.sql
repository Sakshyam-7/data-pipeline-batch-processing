{{ config(
    materialized = 'table'
) }}

WITH stg_listings AS (
    SELECT * FROM {{ ref('stg_listings') }}
)

SELECT
    listing_id,
    host_id,
    property_type,
    room_type,
    city,
    country,
    accommodates,
    bedrooms,
    bathrooms,
    price_per_night
FROM stg_listings

