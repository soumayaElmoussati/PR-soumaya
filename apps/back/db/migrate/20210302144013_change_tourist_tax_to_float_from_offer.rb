class ChangeTouristTaxToFloatFromOffer < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      change_table :offers do |t|
        dir.up   { t.change :tourist_tax, :float }
        dir.down { t.change :tourist_tax, :integer }
      end
    end
  end
end
