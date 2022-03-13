class AddFarmTypeToOffer < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :farm_type, :integer
  end
end
