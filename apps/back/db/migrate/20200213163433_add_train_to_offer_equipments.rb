class AddTrainToOfferEquipments < ActiveRecord::Migration[5.2]
  def change
    add_column :offer_equipments, :train, :boolean, default: false
  end
end
