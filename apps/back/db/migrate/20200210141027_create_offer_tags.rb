class CreateOfferTags < ActiveRecord::Migration[5.2]
  def change
    create_table :offer_tags do |t|
      t.references :offer, foreign_key: true
      t.boolean :playful, default: false
      t.boolean :pedagogic, default: false
      t.boolean :unusual, default: false
      t.boolean :public, default: false
      t.boolean :gustatory, default: false
      t.boolean :animal, default: false
      t.boolean :dirty, default: false
      t.boolean :rewarding, default: false
      t.boolean :depth, default: false
      t.boolean :intensive, default: false
      t.boolean :quick, default: false
      t.boolean :physical, default: false
      t.timestamps
    end
  end
end
