class CreateOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :offers do |t|
      t.references :farmer, foreign_key: true
      t.string :name
      t.string :slug
      t.integer :people_count, default: 0
      t.integer :residence_type, default: 0
      t.integer :price_per_person, default: 0

      t.timestamps
    end
  end
end
