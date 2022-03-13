class AddTaxToOffer < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :tax, :integer, default: 0
  end
end
