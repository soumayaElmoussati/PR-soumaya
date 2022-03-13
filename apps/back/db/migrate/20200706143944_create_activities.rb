class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :name
      t.string :slug
      t.integer :people_count, default: 0
      t.integer :price_per_person, default: 0
      t.integer :additional_traveler_price, default: 0
      t.integer :additional_max_people, default: 0
      t.integer :max_people_count
      t.integer :state, default: 0
      t.references :farmer, foreign_key: true

      t.timestamps
    end
  end
end
