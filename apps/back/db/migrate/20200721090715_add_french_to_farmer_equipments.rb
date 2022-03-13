class AddFrenchToFarmerEquipments < ActiveRecord::Migration[5.2]
  def change
    add_column :farmer_equipments, :french, :boolean, default: false
  end
end
