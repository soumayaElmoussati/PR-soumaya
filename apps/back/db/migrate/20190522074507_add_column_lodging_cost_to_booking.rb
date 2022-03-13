class AddColumnLodgingCostToBooking < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :lodging_cost, :integer, default: 0
  end
end
