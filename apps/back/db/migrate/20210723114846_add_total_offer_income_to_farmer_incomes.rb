class AddTotalOfferIncomeToFarmerIncomes < ActiveRecord::Migration[5.2]
  def change
    add_column :farmer_incomes, :total_offer_income, :float
  end
end
