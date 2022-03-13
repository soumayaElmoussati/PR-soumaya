class AddServiceTotalToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :breakfast_total, :integer, default: 0
    add_column :bookings, :linens_total, :integer, default: 0
    add_column :bookings, :cleaning_total, :integer, default: 0
  end
end
