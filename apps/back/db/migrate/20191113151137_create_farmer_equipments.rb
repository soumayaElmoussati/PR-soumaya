class CreateFarmerEquipments < ActiveRecord::Migration[5.2]
  def change
    create_table :farmer_equipments do |t|
      t.references :farmer, foreign_key: true
      t.boolean :english, default: false
      t.boolean :spanish, default: false
      t.boolean :german, default: false
      t.boolean :italian, default: false
      t.boolean :portuguese, default: false
      t.boolean :russian, default: false
      t.boolean :dutch, default: false
      t.timestamps
    end
  end
end
