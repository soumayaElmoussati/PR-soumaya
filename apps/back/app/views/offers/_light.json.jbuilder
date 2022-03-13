json.extract! offer, :id, :name, :slug, :certificated, :manager, :people_count, :rooms_count, :bathrooms_count, :sleeps_count, :state, :residence_type, :price_per_person, :created_at, :max_people_count, :impressions_count
json.farmer do
  json.extract! offer.farmer, :id, :description
  json.user do
    json.extract! offer.farmer.user, :id, :first_name, :last_name, :ambassador
  end
  if offer.farmer.farmer_organisation.present?
    json.organisation do
      json.extract! offer.farmer.farmer_organisation, :bbc, :adb, :fairefrance
    end
  end
end
json.pictures do
  json.array! offer.cloud_pictures, :order, :public_id, :picture_type, :url
end
json.promotions do
  json.array! offer.offer_promotions, :start_date, :end_date, :amount, :statut
end
json.price_periods do
  json.array! offer.offer_price_periods, :id, :end_date, :price_period
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
    json.extract! offer.address, :id, :city, :state, :street_name, :postal_code, :country_code, :lat, :lng
    if offer.try(:distance)
      json.distance offer.distance
    end
  end
end
if offer.offer_description.present?
  json.description do
    json.extract! offer.offer_description, :id, :residence, :farm, :farmer, :activities,  :discovery, :meeting_animals, :milking_animals, :tasting, :birth_animal, :stroll, :harvest, :craft
  end
end
if offer.offer_equipment.present?
  json.equipment do
    json.extract! offer.offer_equipment, :id, :kitchen, :wifi, :tv, :washing_machine, :fireplace, :parking, :swimming_pool, :domestic_animals, :english_speaking, :private_garden, :shared_garden, :internet, :dvd_player, :games, :dryer, :hair_dryer, :drying_rack, :iron, :wardrobe, :shower, :bath, :baby_bath, :heater, :clim, :fitness, :garden_lounge, :bbq, :oven, :hotplates, :microwaves, :toaster, :kettle, :coffee_machine, :cutlery, :dishwasher, :baby_chair, :fridge, :freezer, :deep_freezer, :garage, :secure_local, :train
  end
end
if offer.offer_service.present?
  json.services do
    json.extract! offer.offer_service, :id, :breakfast, :breakfast_price, :linens, :linens_price, :host_table, :host_table_price, :esprit_ferme, :esprit_link, :cleaning, :cleaning_price, :breakfastopt, :linensopt, :cleaningopt
  end
end
if offer.offer_settlement.present?
  json.settlement do
    json.extract! offer.offer_settlement, :id, :baby_suitable, :child_suitable, :smooking_allowed, :parties_allowed, :additional_rules, :animals_welcome, :accessible
  end
end
