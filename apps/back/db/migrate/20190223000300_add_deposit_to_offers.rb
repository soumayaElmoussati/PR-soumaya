class AddDepositToOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :deposit, :integer, default: 0
  end
end
