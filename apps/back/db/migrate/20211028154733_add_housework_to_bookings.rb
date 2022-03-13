class AddHouseworkToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :housework, :boolean, default: false
    add_column :bookings, :housework_price, :integer
  end
end
