class RemoveColumnBreakfastAndBaseEquipmentsFromOfferEquipments < ActiveRecord::Migration[5.2]
  def change
    remove_column :offer_equipments, :breakfast
    remove_column :offer_equipments, :base_equipments
  end
end
