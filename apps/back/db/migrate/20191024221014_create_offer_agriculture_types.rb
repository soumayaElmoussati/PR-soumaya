class CreateOfferAgricultureTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :offer_agriculture_types do |t|
      t.references :offer, foreign_key: true
      t.boolean :biological, default: false
      t.boolean :permaculture, default: false
      t.boolean :agroecology, default: false
      t.boolean :agroecological, default: false
      t.boolean :conventional, default: false
      t.boolean :ringing, default: false
      t.boolean :durable, default: false
      t.boolean :reliability, default: false
      t.boolean :hydroponics, default: false
      t.timestamps
    end
  end
end
