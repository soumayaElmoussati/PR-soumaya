class AddMinDaysToOfferPricePeriod < ActiveRecord::Migration[5.2]
  def change
    add_column :offer_price_periods, :min_days, :integer, default: 0
  end
end
