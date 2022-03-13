class AddMinDaysToOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :min_days, :integer, default: 1
  end
end
