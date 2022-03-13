class AddManagedToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :channel, :string
    add_column :bookings, :managed, :boolean, default: false
  end
end
