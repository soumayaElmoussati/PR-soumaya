json.bookings do
  json.array! @bookings, partial: 'api/offer/bookings/booking', as: :booking
end
json.external_bookings do
  json.array! @external_bookings, partial: 'api/offer/bookings/external_booking', as: :booking
end