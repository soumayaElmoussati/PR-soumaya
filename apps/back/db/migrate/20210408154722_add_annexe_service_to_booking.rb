class AddAnnexeServiceToBooking < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :annexe_services_total, :integer, default: 0
  end
end
