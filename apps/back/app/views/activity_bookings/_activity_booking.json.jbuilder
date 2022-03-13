json.extract! activity_booking, :id, :status, :client_id, :activity_id, :people_count, :comission_fee, :arrival_date, :departure_date, :total, :promo_code, :created_at, :updated_at
json.activity do
  json.extract! activity_booking.activity, :id, :name, :slug, :departure_time, :departure_min_time, :arriving_time, :arriving_min_time
  if !activity_booking.activity.cloud_activity_pictures.nil?
    json.activity_pictures do
      json.array! activity_booking.activity.cloud_activity_pictures, :order, :public_id, :url
    end
  end
end
json.client do
  json.extract! activity_booking.client, :id
  if !activity_booking.client.user.nil?
    json.user do
      json.extract! activity_booking.client.user, :id, :first_name, :last_name, :cellphone, :phone, :email
    end
  end
end
