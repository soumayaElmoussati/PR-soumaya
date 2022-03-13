class CreateOfferEquipments < ActiveRecord::Migration[5.2]
  def change
    create_table :offer_equipments do |t|
      t.references :offer, foreign_key: true
      t.boolean :breakfast, default: false
      t.boolean :kitchen, default: false
      t.boolean :base_equipments, default: false
      t.boolean :wifi, default: false
      t.boolean :tv, default: false
      t.boolean :washing_machine, default: false
      t.boolean :fireplace, default: false
      t.boolean :parking, default: false
      t.boolean :swimming_pool, default: false
      t.boolean :domestic_animals, default: false
      t.boolean :english_speaking, default: false
    end
  end
end
