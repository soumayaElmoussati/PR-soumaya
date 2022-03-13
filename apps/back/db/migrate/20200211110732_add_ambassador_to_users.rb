class AddAmbassadorToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :ambassador, :boolean, default: false
  end
end
