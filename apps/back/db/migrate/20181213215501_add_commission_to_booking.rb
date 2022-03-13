class AddCommissionToBooking < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :commission, :integer, default: 0
  end
end
