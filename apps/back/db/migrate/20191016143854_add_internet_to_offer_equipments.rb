class AddInternetToOfferEquipments < ActiveRecord::Migration[5.2]
  def change
    add_column :offer_equipments, :internet, :boolean, default: false
  end
end
