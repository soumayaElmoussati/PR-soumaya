class RenameColumnCommission < ActiveRecord::Migration[5.2]
  def change
    rename_column :bookings, :commission, :commission_fee
  end
end
