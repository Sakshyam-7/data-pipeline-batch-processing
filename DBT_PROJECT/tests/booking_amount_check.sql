SELECT 
    booking_id ,
    host_name ,
    city ,
    booking_amount ,
FROM {{ref('obt_bookings')}}
WHERE booking_amount < 0 

    
    