json.extract! booking, :id, :status, :client_id, :offer_id, :contact_number, :people_count, :adult_count, :child_count, :commission_fee, :lodging_cost, :arrival_date, :departure_date, :total, :breakfast_opt, :linens_opt, :cleaning_opt, :promo_code, :sub_total, :annexe_services_total, :stripe_token, :panier_nb, :panier_msg, :panier_total, :bike_rent_nb, :bike_rent_price, :bike_rent_msg, :breakfast_nb, :breakfast_price, :breakfast_msg, :packed_lunch_nb, :packed_lunch_price, :packed_lunch_msg, :cooking_workshop_nb, :cooking_workshop_price, :cooking_workshop_msg, :serenity_nb, :serenity_price, :serenity_msg, :spa_nb, :spa_price, :spa_msg, :car_rent_nb, :car_rent_price, :car_rent_msg, :station_ride_nb, :station_ride_price, :station_ride_msg, :animal_space_nb, :animal_space_price, :animal_space_msg, :host_table_nb, :host_table_price, :host_table_msg, :washing_kit_nb,
:washing_kit_price, :washing_kit_msg, :bbq_nb, :bbq_price, :bbq_msg, :riding_lesson_nb, :riding_lesson_price, :riding_lesson_msg, :horse_ride_nb, :horse_ride_price, :horse_ride_msg, :riding_course_nb, :riding_course_price, :riding_course_msg, :riding_introduction_nb, :riding_introduction_price, :riding_introduction_msg, :immersion_nb, :immersion_price, :immersion_msg, :message, :breakfast_total, :linens_total, :cleaning_total, :receipt_url, :housework, :housework_price, :created_at, :updated_at
json.offer do
  json.extract! booking.offer, :id, :name, :manager, :slug, :departure_time, :departure_min_time, :arriving_time, :arriving_min_time, :residence_type, :annexe_information
  if !booking.offer.offer_service.nil?
    json.offer_service do
      json.extract! booking.offer.offer_service, :id, :breakfast, :linens, :cleaning, :host_table, :esprit_ferme, :breakfastopt, :linensopt, :cleaningopt
    end
  end
  if !booking.offer.cloud_pictures.nil?
    json.offer_pictures do
      json.array! booking.offer.cloud_pictures, :order, :public_id, :picture_type, :url
    end
  end
  json.address do
    json.extract! booking.offer.address, :id, :city, :state, :street_name, :postal_code, :country_code, :lat, :lng
  end
  json.farmer do
    json.extract! booking.offer.farmer, :id, :stripe_link
    if !booking.offer.farmer.user.nil?
      json.user do
        json.extract! booking.offer.farmer.user, :id, :first_name, :last_name, :cellphone, :phone, :email
      end
    end
  end
end
json.client do
  json.extract! booking.client, :id
  if !booking.client.user.nil?
    json.user do
      json.extract! booking.client.user, :id, :first_name, :last_name, :cellphone, :phone, :email
    end
  end
end
json.reviews do
  json.array! booking.reviews, :id, :star, :situation, :lodging, :activity, :services, :contact, :trip_note, :reference, :comment, :state
end
json.farmer_reviews do
  json.array! booking.farmer_reviews, :id, :cleanliness, :communication, :respect, :experience, :welcome, :comment, :state
end