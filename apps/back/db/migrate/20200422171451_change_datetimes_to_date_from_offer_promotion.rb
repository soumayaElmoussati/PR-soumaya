class ChangeDatetimesToDateFromOfferPromotion < ActiveRecord::Migration[5.2]
  def change
    change_table :offer_promotions do |table|
      table.change :start_date, :date
      table.change :end_date, :date
    end
  end
end
