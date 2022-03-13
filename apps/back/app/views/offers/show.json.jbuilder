if !@promocodes.nil?
  json.promocodes do
    json.array! @promocodes, :code, :amount, :state, :max_usage, :count
  end
end
if !@reviews.nil?
  json.reviews do
    json.array! @reviews, :first_name, :star, :residence_type, :comment, :stay_date
  end
end
json.partial! "offers/offer", offer: @offer
# if !@offer.cloud_pictures.nil?
#   json.cloud_pictures do
#     json.array! @offer.cloud_pictures, :order, :public_id, :url
#   end
# end
if !@offer.offer_description.nil?
  json.description do
    json.extract! @offer.offer_description, :id, :residence, :farm, :farmer, :activities,  :discovery, :meeting_animals, :milking_animals, :tasting, :birth_animal, :stroll, :harvest, :craft
  end
end
if !@offer.offer_animal.nil?
  json.animal do
    json.extract! @offer.offer_animal, :id, :cow, :bee, :milk_cow, :sheep, :goat, :pig, :rabbit, :duck, :goose, :turkey, :chicken, :donkey, :snail, :horse, :lama
  end
end
if !@offer.offer_settlement.nil?
  json.settlement do
    json.extract! @offer.offer_settlement, :id, :baby_suitable, :child_suitable, :smooking_allowed, :parties_allowed, :additional_rules, :animals_welcome, :accessible
  end
end
if !@offer.offer_equipment.nil?
  json.equipment do
    json.extract! @offer.offer_equipment, :id, :kitchen, :wifi, :tv,
     :washing_machine, :fireplace, :parking, :swimming_pool, :domestic_animals,
     :english_speaking, :private_garden, :shared_garden, :internet, :dvd_player,
     :games, :dryer, :hair_dryer, :drying_rack, :iron, :wardrobe, :shower,
     :bath, :baby_bath, :heater, :clim, :fitness, :garden_lounge, :bbq, :oven,
     :hotplates, :microwaves, :toaster, :kettle, :coffee_machine, :cutlery,
     :dishwasher, :baby_chair, :fridge, :freezer, :deep_freezer, :garage, :secure_local, :train
  end
end
if !@offer.offer_benefit.nil?
  json.benefit do
    json.extract! @offer.offer_benefit, :id, :cleaning_kit, :toilet_paper, :soap, :household_linen
  end
end
if !@offer.offer_service.nil?
  json.service do
    json.extract! @offer.offer_service, :id, :breakfast, :breakfast_price, :linens, :linens_price, :host_table, :host_table_price, :esprit_ferme, :esprit_link, :cleaning, :cleaning_price, :breakfastopt, :linensopt, :cleaningopt
  end
end
if !@offer.offer_farm_type.nil?
  json.farm_type do
    json.extract! @offer.offer_farm_type, :id, :breeder, :cereal, :horticulturist, :market_gardener, :cheese_production, :winegrower, :brewer, :arborist, :oyster_farmer, :mushroom_grower, :beekeeper, :cider_maker, :riding_stable, :agroforestry
  end
end
if !@offer.offer_agriculture_type.nil?
  json.agriculture_type do
    json.extract! @offer.offer_agriculture_type, :id, :biological, :permaculture, :agroecology, :agroecological, :conventional, :ringing, :durable, :reliability, :hydroponics
  end
end
if !@offer.offer_adjectif.nil?
  json.adjectif do
    json.extract! @offer.offer_adjectif, :id, :rustic, :luxurious, :confortable, :clean, :friendly, :calm, :exotic, :romantic, :cheap, :insolit, :simple, :luminous
  end
end
if !@offer.offer_tag.nil?
  json.tag do
    json.extract! @offer.offer_tag, :id, :playful, :pedagogic, :unusual, :public, :gustatory, :animal, :dirty, :rewarding, :depth, :intensive, :quick, :physical
  end
end
json.rooms do
  json.array! @offer.offer_rooms, :id, :simple_bed, :double_bed, :private_bathroom
end
if !@offer.offer_price_discounts.nil?
  json.price_discount do
    json.array! @offer.offer_price_discounts, :id, :percentage_discount, :min_nights
  end
end
if !@offer.annexe_services.nil?
  json.annexe_service do
    json.array! @offer.annexe_services, :id, :name, :description, :price, :unity
  end
end

if !@offer.offer_price_weekend.nil?
  json.price_weekend do
    json.extract! @offer.offer_price_weekend, :id, :price, :both_days
  end
end

if !@offer.offer_promotions.nil?
  json.promotions do
    json.array! @offer.offer_promotions, :id, :start_date, :end_date, :amount, :statut
  end
end

if !@offer.offer_price_periods.nil?
  json.price_period do
    json.array! @offer.offer_price_periods, :id, :start_date, :end_date, :use_discount, :min_days, :price_period
  end
  if !@offer.events.nil?
    json.events do
      json.array! @offer.events do |event|
         json.id event.id
         json.title event.status
         json.allDay true
         json.start event.arrival_date.strftime("%F")
         json.end event.departure_date.strftime("%F")
         event.status == "unavailable" ? json.editable(true) : json.editable(false)
         event.status == "unavailable" ? json.color('black') : json.color('red')
         json.overlap false
         json.textColor('white')
      end
    end
  end
end
