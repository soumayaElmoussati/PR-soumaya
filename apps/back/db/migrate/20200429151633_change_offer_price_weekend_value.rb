class ChangeOfferPriceWeekendValue < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:offer_price_weekends, :price, nil)
  end
end
