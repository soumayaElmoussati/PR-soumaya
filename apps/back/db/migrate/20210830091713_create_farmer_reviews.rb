class CreateFarmerReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :farmer_reviews do |t|
      t.string :first_name
      t.string :last_name
      t.integer :cleanliness
      t.integer :communication
      t.integer :respect
      t.integer :experience
      t.boolean :welcome
      t.integer :state, default: 1
      t.text :comment

      t.timestamps
    end
  end
end
