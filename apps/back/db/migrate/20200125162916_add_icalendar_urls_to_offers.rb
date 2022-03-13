class AddIcalendarUrlsToOffers < ActiveRecord::Migration[5.2]
  def up
    remove_column :offers, :icalendar_url
    add_column :offers, :icalendar_urls, :string, array: true, default: [], null: false
  end

  def down
    add_column :offers, :icalendar_url, :string
    remove_column :offers, :icalendar_urls
  end
end
