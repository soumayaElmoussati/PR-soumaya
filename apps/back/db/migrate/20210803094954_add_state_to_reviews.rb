class AddStateToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :state, :integer, default: 1
  end
end
