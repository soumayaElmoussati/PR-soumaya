class AddTouristTaxToOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :tourist_tax, :integer, default: 0
  end
end
