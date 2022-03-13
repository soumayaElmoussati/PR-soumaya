class AddFarmerDepositToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :farmer_deposit, :integer
  end
end
