# frozen_string_literal: true

json.extract! booking, :id, :uid, :start, :end, :notes
if booking.source == 'manual'
  json.provider :manual
else
  json.provider :external
end
