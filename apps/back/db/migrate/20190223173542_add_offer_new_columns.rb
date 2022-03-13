class AddOfferNewColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :max_people_count, :integer, default: 1
    add_column :offers, :toilets_count, :integer, default: 1
    add_column :offers, :sleeps_count, :integer, default: 0
    add_column :offers, :bathrooms_count, :integer, default: 1
    add_column :offers, :rooms_count, :integer, default: 1
  end
end
