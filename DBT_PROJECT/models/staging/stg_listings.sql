WITH raw_listings AS (
    SELECT * 
    FROM {{ source('airbnb_raw', 'listings') }}
),

cleaned_listings AS (
    SELECT
        listing_id,
        host_id,
        
        -- Applying the string cleaning macro to standardize textual dimensions
        {{ clean_string('property_type') }} AS property_type,
        {{ clean_string('room_type') }} AS room_type,
        {{ clean_string('city') }} AS city,
        {{ clean_string('country') }} AS country,
        
        accommodates,
        bedrooms,
        bathrooms,
        -- Casting the actual price column to a proper decimal
        CAST(price_per_night AS NUMBER(10,2)) AS price_per_night,
        created_at
    FROM raw_listings
    WHERE listing_id IS NOT NULL
    
    -- Using the raw file's 'created_at' for deduplication ordering
    QUALIFY ROW_NUMBER() OVER (PARTITION BY listing_id ORDER BY created_at DESC) = 1
)

SELECT * FROM cleaned_listings