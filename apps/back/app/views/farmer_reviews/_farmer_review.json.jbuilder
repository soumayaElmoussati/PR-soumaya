json.extract! farmer_review, :id, :booking_id, :comment, :first_name, :last_name, :full_name, :state, :cleanliness, :communication, :respect, :experience, :welcome
json.booking do
  json.extract! farmer_review.booking, :id
  if !farmer_review.booking.client.user.nil?
    json.user do
      json.extract! farmer_review.booking.client.user, :id, :first_name, :last_name, :cellphone, :phone, :email
    end
  end
end