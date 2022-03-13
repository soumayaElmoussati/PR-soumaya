class AddStayCountToFarmerIncomes < ActiveRecord::Migration[5.2]
  def change
    add_column :farmer_incomes, :stay_count, :integer
  end
end
