class AddMissingOfferIndexes < ActiveRecord::Migration[5.2]
  def up
    add_index :offers, :slug
    add_index :offers, :residence_type
    add_index :offers, :state
    add_index :offers, :max_people_count
  end

  def down
    remove_index :offers, :slug
    remove_index :offers, :residence_type
    remove_index :offers, :state
    remove_index :offers, :max_people_count
  end
end
