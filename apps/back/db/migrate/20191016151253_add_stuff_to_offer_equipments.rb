class AddStuffToOfferEquipments < ActiveRecord::Migration[5.2]
  def change
    add_column :offer_equipments, :dvd_player, :boolean, default: false
    add_column :offer_equipments, :games, :boolean, default: false
    add_column :offer_equipments, :dryer, :boolean, default: false
    add_column :offer_equipments, :hair_dryer, :boolean, default: false
    add_column :offer_equipments, :drying_rack, :boolean, default: false
    add_column :offer_equipments, :iron, :boolean, default: false
    add_column :offer_equipments, :wardrobe, :boolean, default: false
    add_column :offer_equipments, :shower, :boolean, default: false
    add_column :offer_equipments, :bath, :boolean, default: false
    add_column :offer_equipments, :baby_bath, :boolean, default: false
    add_column :offer_equipments, :heater, :boolean, default: false
    add_column :offer_equipments, :clim, :boolean, default: false
    add_column :offer_equipments, :fitness, :boolean, default: false
    add_column :offer_equipments, :garden_lounge, :boolean, default: false
    add_column :offer_equipments, :bbq, :boolean, default: false
    add_column :offer_equipments, :oven, :boolean, default: false
    add_column :offer_equipments, :hotplates, :boolean, default: false
    add_column :offer_equipments, :microwaves, :boolean, default: false
    add_column :offer_equipments, :toaster, :boolean, default: false
    add_column :offer_equipments, :kettle, :boolean, default: false
    add_column :offer_equipments, :coffee_machine, :boolean, default: false
    add_column :offer_equipments, :cutlery, :boolean, default: false
    add_column :offer_equipments, :dishwasher, :boolean, default: false
    add_column :offer_equipments, :baby_chair, :boolean, default: false
    add_column :offer_equipments, :fridge, :boolean, default: false
    add_column :offer_equipments, :freezer, :boolean, default: false
    add_column :offer_equipments, :garage, :boolean, default: false
    add_column :offer_equipments, :secure_local, :boolean, default: false
  end
end
