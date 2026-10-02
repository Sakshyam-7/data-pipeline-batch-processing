 {% macro obt_sales_config() %}

{% set config = {
    'base': {
        'model': 'fact_bookings',
        'alias': 'b',
        'columns': [
            'booking_id',
            'booking_date',
            'listing_id' ,
            'booking_status',
            'nights_booked',
            'booking_amount',
            'base_booking_cost',
            'cleaning_fee',
            'service_fee',
            'created_at'
        ]
    },

    'joins': [
        {
            'model': 'dim_listings',
            'alias': 'l',
            'type': 'left',
            'on': 'b.listing_id = l.listing_id',
            'columns': [
                {'name': 'property_type'},
                {'name': 'room_type'},
                {'name': 'city'},
                {'name': 'country'},
                {'name': 'price_per_night'}
            ]
        },
        {
            'model': 'dim_hosts',
            'alias': 'h',
            'type': 'left',
            'on': 'b.host_snapshot_id = h.dbt_scd_id',
            'columns': [
                {'name': 'host_name'},
                {'name': 'is_superhost'},
                {'name': 'response_rate'}
            ]
        }
    ],

    'derived': [
        {
            'name': 'total_fees',
            'expr': 'b.cleaning_fee + b.service_fee'
        }
    ]
} %}

{{ return(config) }}

{% endmacro %}