class AddPriceOfferIndex < ActiveRecord::Migration[5.2]
  def up
    add_index :offers, :price_per_person
  end

  def down
    remove_index :offers, :price_per_person
  end
end
