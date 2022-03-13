class AddPromoToBoookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :promo_code, :string
  end
end
