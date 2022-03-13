class AddStateToActivityAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :activity_addresses, :state, :string
  end
end
