class UpdateColumnMaxPeopleCount < ActiveRecord::Migration[5.2]
  def up
    change_column :offers, :max_people_count, :integer, default: nil
  end

  def down
    change_column :offers, :max_people_count, :integer, default: 1
  end
end
