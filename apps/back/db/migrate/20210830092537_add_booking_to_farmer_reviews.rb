class AddBookingToFarmerReviews < ActiveRecord::Migration[5.2]
  def change
    add_reference :farmer_reviews, :booking, foreign_key: true
  end
end
