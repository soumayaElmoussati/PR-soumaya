class AddArrivingTimeToOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :arriving_time, :integer, default: 14
    add_column :offers, :departure_min_time, :integer, default: 0
    add_column :offers, :arriving_min_time, :integer, default: 0
  end
end
