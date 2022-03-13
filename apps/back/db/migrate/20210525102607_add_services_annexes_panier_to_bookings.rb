class AddServicesAnnexesPanierToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :panier_nb, :integer
    add_column :bookings, :panier_msg, :text
    add_column :bookings, :panier_total, :integer
  end
end
