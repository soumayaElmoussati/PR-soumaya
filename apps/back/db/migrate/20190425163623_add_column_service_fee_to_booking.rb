class AddColumnServiceFeeToBooking < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :service_fee, :integer, default: 0
  end
end
