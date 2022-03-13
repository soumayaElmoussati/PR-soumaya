class AddOptionalServiceToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :breakfast_opt, :boolean, default: false
    add_column :bookings, :linens_opt, :boolean, default: false
    add_column :bookings, :cleaning_opt, :boolean, default: false
  end
end
