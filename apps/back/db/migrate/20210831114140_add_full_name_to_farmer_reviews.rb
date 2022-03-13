class AddFullNameToFarmerReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :farmer_reviews, :full_name, :string
  end
end
