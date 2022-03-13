class AddBoookingsCountToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :bookings_count, :integer
  end
end
