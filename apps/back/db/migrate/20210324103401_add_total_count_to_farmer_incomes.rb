class AddTotalCountToFarmerIncomes < ActiveRecord::Migration[5.2]
  def change
    add_column :farmer_incomes, :total_farmer_balance, :float
  end
end
