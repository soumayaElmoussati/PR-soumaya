class AddNotesToExternalBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :external_bookings, :notes, :text
  end
end
