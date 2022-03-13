every 6.hours do
  runner "Offer.fetch_external_bookings"
end
every 1.days do
   runner "Booking.stay_reminder"
end
