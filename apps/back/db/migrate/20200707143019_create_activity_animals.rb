class CreateActivityAnimals < ActiveRecord::Migration[5.2]
  def change
    create_table :activity_animals do |t|
      t.references :activity, foreign_key: true
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
      t.boolean :donkey, default: false
      t.boolean :snail, default: false
      t.boolean :horse, default: false
      t.boolean :bee, default: false
      t.boolean :lama, default: false
      t.timestamps
    end
  end
end
