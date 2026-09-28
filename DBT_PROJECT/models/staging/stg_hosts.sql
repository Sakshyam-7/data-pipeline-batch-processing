WITH raw_hosts AS (
    SELECT * 
    FROM {{ source('airbnb_raw', 'hosts') }}
),

cleaned_hosts AS (
    SELECT
        host_id,
        
        {{ clean_string('host_name') }} AS host_name,
        
        host_since,
        is_superhost,
        response_rate,
        created_at
    FROM raw_hosts
    WHERE host_id IS NOT NULL
    
    QUALIFY ROW_NUMBER() OVER (PARTITION BY host_id ORDER BY created_at DESC) = 1
)

SELECT * FROM cleaned_hosts