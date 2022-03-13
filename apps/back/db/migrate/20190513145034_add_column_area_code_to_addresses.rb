class AddColumnAreaCodeToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :area_code, :string
  end
end
