class CreateOfferPromotions < ActiveRecord::Migration[5.2]
  def change
    create_table :offer_promotions do |t|
      t.references :offer, foreign_key: true
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.integer :amount, null: false
      t.boolean :statut, default: false

      t.timestamps
    end
  end
end
