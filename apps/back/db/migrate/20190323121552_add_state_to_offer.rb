class AddStateToOffer < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :state, :integer, default: 0
  end
end
