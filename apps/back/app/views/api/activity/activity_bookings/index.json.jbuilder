json.activity_bookings do
  json.array! @activity_bookings, partial: 'api/activity/activity_bookings/activity_booking', as: :activity_booking
end
json.external_activity_bookings do
  json.array! @external_activity_bookings, partial: 'api/activity/activity_bookings/external_activity_booking', as: :activity_booking
end
