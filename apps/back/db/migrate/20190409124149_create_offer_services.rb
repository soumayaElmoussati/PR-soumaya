class CreateOfferServices < ActiveRecord::Migration[5.2]
  def change
    create_table :offer_services do |t|
      t.references :offer, foreign_key: true
      t.boolean :breakfast, default: false
      t.integer :breakfast_price, default: 0, numericality: true
      t.boolean :linens, default: false
      t.integer :linens_price, default: 0, numericality: true
      t.boolean :cleaning, default: false
      t.integer :cleaning_price, default: 0, numericality: true
      t.timestamps
    end
  end
end