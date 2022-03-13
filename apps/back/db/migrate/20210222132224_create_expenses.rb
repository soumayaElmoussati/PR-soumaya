class CreateExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses do |t|
      t.string :responsable
      t.references :offer, foreign_key: true
      t.date :expense_date
      t.float :total_ttc
      t.float :total_ht
      t.text :comment

      t.timestamps
    end
  end
end
