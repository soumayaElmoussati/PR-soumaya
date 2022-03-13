class AddDepartureTimeToOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :departure_time, :integer, default: 11
  end
end
