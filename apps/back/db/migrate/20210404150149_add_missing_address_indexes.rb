class AddMissingAddressIndexes < ActiveRecord::Migration[5.2]
  def up
    add_index :addresses, :offer_id
    add_index :addresses, :area_code
  end

  def down
    remove_index :addresses, :offer_id
    remove_index :addresses, :area_code
  end
end
