class AddHoursToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :departure_time, :integer, default: 11
    add_column :activities, :arriving_time, :integer, default: 14
    add_column :activities, :departure_min_time, :integer, default: 0
    add_column :activities, :arriving_min_time, :integer, default: 0
  end
end
