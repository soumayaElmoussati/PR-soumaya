# frozen_string_literal: true

json.extract! activity_booking, :id, :uid, :start, :end, :notes
if activity_booking.source == 'manual'
  json.provider :manual
else
  json.provider :external
end
