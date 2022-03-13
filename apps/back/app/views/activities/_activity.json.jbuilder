json.extract! activity, :id, :name, :slug, :people_count, :state, :price_per_person, :created_at, :max_people_count, :additional_traveler_price, :additional_max_people, :departure_time, :departure_min_time, :arriving_time, :arriving_min_time
json.farmer do
  json.extract! activity.farmer, :id, :description, :agriculteur_de_bretagne
  json.user do
    json.extract! activity.farmer.user, :id, :first_name, :last_name, :ambassador, :email
  end
  json.farmerpictures do
    json.array! activity.farmer.cloud_profile_pictures, :public_id, :url, :order
  end
end
json.pictures do
  json.array! activity.cloud_activity_pictures, :order, :public_id, :url
end
if activity.activity_farm_type.present?
  json.farm_types do
    json.extract! activity.activity_farm_type, :id, :breeder, :cereal, :horticulturist, :market_gardener, :cheese_production, :winegrower, :brewer, :arborist, :oyster_farmer, :mushroom_grower, :beekeeper, :cider_maker, :riding_stable, :agroforestry
  end
end
if activity.activity_agriculture_type.present?
  json.agriculture_types do
    json.extract! activity.activity_agriculture_type, :id, :biological, :permaculture, :agroecology, :agroecological, :conventional, :ringing, :durable, :reliability, :hydroponics
  end
end
if activity.activity_animal.present?
  json.animals do
    json.extract! activity.activity_animal, :id, :cow, :bee, :milk_cow, :sheep, :goat, :pig, :rabbit, :duck, :goose, :turkey, :chicken, :donkey, :snail, :horse, :lama
  end
end
if activity.activity_address.present?
  json.activity_address do
    json.extract! activity.activity_address, :id, :city, :state, :street_name, :postal_code, :country_code, :lat, :lng
    if activity.try(:distance)
      json.distance activity.distance
    end
  end
end
