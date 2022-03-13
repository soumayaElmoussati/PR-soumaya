class AddPercentageInverseurToOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :inverseur_percentage, :float
  end
end
