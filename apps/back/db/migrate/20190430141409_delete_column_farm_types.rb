class DeleteColumnFarmTypes < ActiveRecord::Migration[5.2]
  def up
    remove_column :offers, :farm_types
  end

  def down
    add_column :offers, :farm_types, :text, array: true, default: []
  end
end
