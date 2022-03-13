class RemoveFarmTypeFromOffer < ActiveRecord::Migration[5.2]
  def change
    remove_column :offers, :farm_type, :integer
  end
end
