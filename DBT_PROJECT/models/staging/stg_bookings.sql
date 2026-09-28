WITH raw_bookings AS (
    SELECT * 
    FROM {{ source('airbnb_raw', 'bookings') }}
),

cleaned_bookings AS (
    SELECT
        booking_id,
        listing_id,
        booking_date,
        nights_booked,
        CAST(booking_amount AS NUMBER(10,2)) AS booking_amount,
        CAST(cleaning_fee AS NUMBER(10,2)) AS cleaning_fee,
        CAST(service_fee AS NUMBER(10,2)) AS service_fee,
        
        -- 1. Applying the trim/upper macro to a valid string column
        {{ clean_string('booking_status') }} AS booking_status,
        
        -- 2. Applying your multiplication macro
        {{ multiply_column('booking_amount', 'nights_booked', 'base_booking_cost') }},
        
        created_at
    FROM raw_bookings
    WHERE booking_id IS NOT NULL
    
    QUALIFY ROW_NUMBER() OVER (PARTITION BY booking_id ORDER BY created_at DESC) = 1
)

SELECT * FROM cleaned_bookings