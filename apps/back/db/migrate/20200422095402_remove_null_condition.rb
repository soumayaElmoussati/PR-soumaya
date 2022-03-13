class RemoveNullCondition < ActiveRecord::Migration[5.2]
  def change
    change_column_null :offer_promotions, :start_date, true
    change_column_null :offer_promotions, :end_date, true
    change_column_null :offer_promotions, :amount, true
  end
end
