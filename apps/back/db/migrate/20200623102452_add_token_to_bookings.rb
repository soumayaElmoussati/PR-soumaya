class AddTokenToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :stripe_token, :string
  end
end
