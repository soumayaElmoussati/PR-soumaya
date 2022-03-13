class AddFarmTypesToOffer < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :farm_types, :text, array: true, default: []
  end
end
