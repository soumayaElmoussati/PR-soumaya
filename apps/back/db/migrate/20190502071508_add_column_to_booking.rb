class AddColumnToBooking < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :offer_price_per_night, :integer, default: 0
    add_column :bookings, :sub_total, :integer, default: 0
    add_column :bookings, :total_services, :integer, default: 0
    add_column :bookings, :occupancy_tax, :integer, default: 0    
  end
end
