class AddAdultChildenCountToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :adult_count, :integer
    add_column :bookings, :child_count, :integer
  end
end
