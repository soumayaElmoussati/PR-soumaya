class CreateOfferPricePeriods < ActiveRecord::Migration[5.2]
  def change
    create_table :offer_price_periods do |t|
      t.references :offer, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.integer :price_period, default: 0, numericality: true
      t.timestamps
    end
  end
end
