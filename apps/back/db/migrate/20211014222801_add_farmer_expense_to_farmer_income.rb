class AddFarmerExpenseToFarmerIncome < ActiveRecord::Migration[5.2]
  def change
    add_column :farmer_incomes, :farmer_expenses, :float
  end
end
