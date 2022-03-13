class CreateOfferAdjectifs < ActiveRecord::Migration[5.2]
  def change
    create_table :offer_adjectifs do |t|
      t.references :offer, foreign_key: true
      t.boolean :rustic, default: false
      t.boolean :luxurious, default: false
      t.boolean :confortable, default: false
      t.boolean :clean, default: false
      t.boolean :friendly, default: false
      t.boolean :calm, default: false
      t.boolean :exotic, default: false
      t.boolean :romantic, default: false
      t.boolean :cheap, default: false
      t.boolean :insolit, default: false
      t.boolean :simple, default: false
      t.boolean :luminous, default: false
      t.timestamps
    end
  end
end
