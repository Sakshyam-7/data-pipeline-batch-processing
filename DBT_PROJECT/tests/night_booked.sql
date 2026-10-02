SELECT
    booking_id ,
    nights_booked ,
FROM {{ref('obt_bookings')}}
WHERE nights_booked <= 0