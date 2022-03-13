json.partial! "farmers/farmer", farmer: @farmer

if !@farmer.farmer_equipment.nil?
  json.equipment do
    json.extract! @farmer.farmer_equipment, :id, :english, :spanish, :german, :italian, :portuguese, :russian, :dutch, :french
  end
end

if !@farmer.farmer_organisation.nil?
  json.organisation do
    json.extract! @farmer.farmer_organisation, :id, :fairefrance, :adb, :bbc
  end
end
