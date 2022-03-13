class RemoveUidToExternalBookings < ActiveRecord::Migration[5.2]
  def change
    remove_index :external_bookings, name: "index_external_bookings_on_uid"
  end
end
