json.extract! review, :id, :star, :booking_id, :residence_type, :comment, :stay_date, :first_name, :last_name, :full_name, :situation, :lodging, :activity, :services, :contact, :process, :reference, :trip_note, :recipient, :street_name, :city, :postal_code, :country_code
json.booking do
  json.extract! review.booking, :id
  if !review.booking.client.user.nil?
    json.user do
      json.extract! review.booking.client.user, :id, :first_name, :last_name, :cellphone, :phone, :email
    end
  end
end