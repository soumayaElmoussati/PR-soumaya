class AddDeepFreezerToOfferEquipments < ActiveRecord::Migration[5.2]
  def change
    add_column :offer_equipments, :deep_freezer, :boolean, default: false
  end
end
