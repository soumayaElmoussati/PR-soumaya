json.partial! "activities/activity", activity: @activity
# if !@activity.cloud_activity_pictures.nil?
#   json.cloud_activity_pictures do
#     json.array! @activity.cloud_activity_pictures, :order, :public_id, :url
#   end
# end
if !@activity.activity_description.nil?
  json.description do
    json.extract! @activity.activity_description, :id, :residence, :farm, :farmer, :activities,  :discovery, :meeting_animals, :milking_animals, :tasting, :birth_animal, :stroll, :harvest, :craft
  end
end
if !@activity.activity_farm_type.nil?
  json.farm_type do
    json.extract! @activity.activity_farm_type, :id, :breeder, :cereal, :horticulturist, :market_gardener, :cheese_production, :winegrower, :brewer, :arborist, :oyster_farmer, :mushroom_grower, :beekeeper, :cider_maker, :riding_stable, :agroforestry
  end
end
if !@activity.activity_agriculture_type.nil?
  json.agriculture_type do
    json.extract! @activity.activity_agriculture_type, :id, :biological, :permaculture, :agroecology, :agroecological, :conventional, :ringing, :durable, :reliability, :hydroponics
  end
end
if !@activity.activity_tag.nil?
  json.tag do
    json.extract! @activity.activity_tag, :id, :playful, :pedagogic, :unusual, :public, :gustatory, :animal, :dirty, :rewarding, :depth, :intensive, :quick, :physical
  end
end
if !@activity.activity_animal.nil?
  json.animal do
    json.extract! @activity.activity_animal, :id, :cow, :bee, :milk_cow, :sheep, :goat, :pig, :rabbit, :duck, :goose, :turkey, :chicken, :donkey, :snail, :horse, :lama
  end
end
if !@activity.activity_settlement.nil?
  json.settlement do
    json.extract! @activity.activity_settlement, :id, :baby_suitable, :child_suitable, :smooking_allowed, :parties_allowed, :additional_rules, :animals_welcome, :accessible
  end
end
