select *
from hotels.booking


select *
from hotels.hotel
where hotelcity LIKE '%New York%'



select * from hotels.guest

select *
from hotels.booking
where checkin > '2017-03-14T02:00:00'



SELECT
    B.bookingNo,
    H.hotelName,
    H.hotelType,
    H.hotelAddress,
    H.hotelCity,
    B.roomNo,
    G.firstName,
    G.lastName,
    B.checkIn,
    B.checkout
FROM hotels.hotel H
JOIN hotels.booking B
ON H.hotelNo = B.hotelNo
JOIN hotels.guest G
ON B.guestNo = G.guestNo
WHERE G.guestAddress = 'New York';

SELECT G.*
FROM hotels.hotel H
JOIN hotels.booking B
ON H.hotelNo = B.hotelNo
JOIN hotels.guest G
ON B.guestNo = G.guestNo
WHERE G.guestAddress LIKE '%New York%'
ORDER BY G.lastName DESC;


