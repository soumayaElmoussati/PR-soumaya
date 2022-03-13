class AddAdditionalTravelerPriceToOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :additional_traveler_price, :integer, default: 0
  end
end
