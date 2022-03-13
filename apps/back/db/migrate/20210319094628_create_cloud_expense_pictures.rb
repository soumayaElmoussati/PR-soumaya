class CreateCloudExpensePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :cloud_expense_pictures do |t|
      t.string :public_id
      t.string :url
      t.references :expense, foreign_key: true
      t.integer :order

      t.timestamps
    end
  end
end
