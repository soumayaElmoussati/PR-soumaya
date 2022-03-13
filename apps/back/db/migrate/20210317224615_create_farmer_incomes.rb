class CreateFarmerIncomes < ActiveRecord::Migration[5.2]
  def change
    create_table :farmer_incomes do |t|
      t.references :offer, foreign_key: true
      t.integer :state, default: 0
      t.date :start_date
      t.date :end_date
      t.string :period_name
      t.text :note
      t.float :expenses_balance
      t.float :lodging_income_balance
      t.float :farmer_balance
      t.float :housework_income_balance
      t.float :annexes_incomes_balance

      t.timestamps
    end
  end
end
