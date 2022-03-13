class AddImpressionsCountToOffer < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :impressions_count, :integer, default: 1
  end
end
