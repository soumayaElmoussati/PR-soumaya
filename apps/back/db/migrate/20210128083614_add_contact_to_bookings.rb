class AddContactToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :contact_number, :string
    add_column :bookings, :message, :text
  end
end
