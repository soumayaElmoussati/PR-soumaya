class AddMissingBookingIndexes < ActiveRecord::Migration[5.2]
  def up
    add_index :bookings, :status
    add_index :bookings, :arrival_date
    add_index :bookings, :departure_date
  end

  def down
    remove_index :bookings, :status
    remove_index :bookings, :arrival_date
    remove_index :bookings, :departure_date
  end
end
