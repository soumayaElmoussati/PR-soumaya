class AddIcalToOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :icalendar_url, :string
  end
end
