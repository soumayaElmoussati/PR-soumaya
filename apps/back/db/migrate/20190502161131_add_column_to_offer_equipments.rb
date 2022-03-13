class AddColumnToOfferEquipments < ActiveRecord::Migration[5.2]
  def change
    add_column :offer_equipments, :private_garden, :boolean, default: false
    add_column :offer_equipments, :shared_garden, :boolean, default: false
  end
end
