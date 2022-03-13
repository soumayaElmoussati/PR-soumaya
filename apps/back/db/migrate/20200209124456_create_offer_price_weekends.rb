class CreateOfferPriceWeekends < ActiveRecord::Migration[5.2]
  def change
    create_table :offer_price_weekends do |t|
      t.references :offer, foreign_key: true
      t.integer :price, default: 0
      t.boolean :both_days, default: false
      t.timestamps
    end
  end
end
