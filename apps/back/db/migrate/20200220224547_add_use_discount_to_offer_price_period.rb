class AddUseDiscountToOfferPricePeriod < ActiveRecord::Migration[5.2]
  def change
    add_column :offer_price_periods, :use_discount, :boolean, default: false
  end
end
