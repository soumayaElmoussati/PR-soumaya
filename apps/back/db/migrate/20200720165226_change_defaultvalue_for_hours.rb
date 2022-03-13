class ChangeDefaultvalueForHours < ActiveRecord::Migration[5.2]
  def up
    change_column_default :activities, :departure_time, 16
    change_column_default :activities, :departure_min_time, 30
  end

  def down
    change_column_default :activities, :departure_time, 11
    change_column_default :activities, :departure_min_time, 0
  end
end
