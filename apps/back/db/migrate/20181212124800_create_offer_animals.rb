class CreateOfferAnimals < ActiveRecord::Migration[5.2]
  def change
    create_table :offer_animals do |t|
      t.references :offer
      t.boolean :cow, default: false
      t.boolean :milk_cow, default: false
      t.boolean :sheep, default: false
      t.boolean :goat, default: false
      t.boolean :pig, default: false
      t.boolean :rabbit, default: false
      t.boolean :duck, default: false
      t.boolean :goose, default: false
      t.boolean :turkey, default: false
      t.boolean :chicken, default: false
    end
  end
end
