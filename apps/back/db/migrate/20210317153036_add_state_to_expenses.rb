class AddStateToExpenses < ActiveRecord::Migration[5.2]
  def change
    add_column :expenses, :state, :integer, default: 1
  end
end
