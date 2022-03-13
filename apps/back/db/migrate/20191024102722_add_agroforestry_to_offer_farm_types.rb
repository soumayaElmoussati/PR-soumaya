class AddAgroforestryToOfferFarmTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :offer_farm_types, :agroforestry, :boolean, default: false
  end
end
