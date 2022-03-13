json.extract! offer, :id, :name, :slug, :certificated, :instant_booking, :manager, :people_count, :state, :residence_type, :price_per_person, :created_at, :max_people_count, :toilets_count, :sleeps_count, :bathrooms_count, :rooms_count, :annexe_information, :icalendar_urls, :departure_time, :departure_min_time, :arriving_time, :arriving_min_time, :additional_traveler_price, :additional_max_people, :min_days, :deposit, :tourist_tax, :impressions_count
json.farmer do
  json.extract! offer.farmer, :id, :description
  json.user do
    json.extract! offer.farmer.user, :id, :first_name, :last_name, :ambassador, :email
  end
  if offer.farmer.farmer_organisation.present?
    json.organisation do
      json.extract! offer.farmer.farmer_organisation, :bbc, :adb, :fairefrance
    end
  end
  json.farmerpictures do
    json.array! offer.farmer.cloud_profile_pictures, :public_id, :url, :order
  end
end
json.pictures do
  json.array! offer.cloud_pictures, :order, :public_id, :picture_type, :url
end
json.picturesoffer do
  json.array! offer.cloud_offer_pictures, :order, :public_id, :url
end
json.promotions do
  json.array! offer.offer_promotions, :start_date, :end_date, :amount, :statut
end
if offer.offer_animal.present?
  json.animals do
    json.extract! offer.offer_animal, :id, :cow, :bee, :milk_cow, :sheep, :goat, :pig, :rabbit, :duck, :goose, :turkey, :chicken, :donkey, :snail, :horse, :lama
  end
end
if offer.offer_farm_type.present?
  json.farm_types do
    json.extract! offer.offer_farm_type, :id, :breeder, :cereal, :horticulturist, :market_gardener, :cheese_production, :winegrower, :brewer, :arborist, :oyster_farmer, :mushroom_grower, :beekeeper, :cider_maker, :riding_stable, :agroforestry
  end
end
if offer.offer_agriculture_type.present?
  json.agriculture_types do
    json.extract! offer.offer_agriculture_type, :id, :biological, :permaculture, :agroecology, :agroecological, :conventional, :ringing, :durable, :reliability, :hydroponics
  end
end
if offer.address.present?
  json.address do
    json.extract! offer.address, :id, :city, :state, :street_name, :postal_code, :country_code, :lat, :lng, :region, :department
    if offer.try(:distance)
      json.distance offer.distance
    end
  end
end
