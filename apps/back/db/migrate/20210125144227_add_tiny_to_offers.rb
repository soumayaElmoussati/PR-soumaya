class AddTinyToOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :manager, :boolean, default: false
    add_column :offers, :instant_booking, :boolean, default: false
  end
end
