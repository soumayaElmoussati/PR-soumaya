class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :star
      t.integer :residence_type
      t.text :comment
      t.date :stay_date
      t.string :first_name
      t.string :last_name
      t.string :full_name

      t.timestamps
    end
  end
end
