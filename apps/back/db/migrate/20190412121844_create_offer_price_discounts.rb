class CreateOfferPriceDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :offer_price_discounts do |t|
      t.references :offer, foreign_key: true
      t.integer :percentage_discount, default: 0, numericality: true
      t.integer :min_nights, default: 0, numericality: true
      t.timestamps
    end
  end
end
