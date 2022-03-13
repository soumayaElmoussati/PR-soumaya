class CreatePromocodes < ActiveRecord::Migration[5.2]
  def change
    create_table :promocodes do |t|
      t.string :name
      t.integer :amount
      t.boolean :state, default: false
      t.string :code

      t.timestamps
    end
  end
end
