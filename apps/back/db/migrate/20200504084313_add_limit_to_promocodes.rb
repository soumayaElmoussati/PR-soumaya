class AddLimitToPromocodes < ActiveRecord::Migration[5.2]
  def change
    add_column :promocodes, :count, :integer, default: 0
    add_column :promocodes, :max_usage, :integer
  end
end
