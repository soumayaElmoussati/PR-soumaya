class ChangeCalendarDefaultValue < ActiveRecord::Migration[5.2]
  def change
    change_column_null :offers, :icalendar_urls, true
  end
end
