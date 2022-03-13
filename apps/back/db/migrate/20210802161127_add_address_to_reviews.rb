class AddAddressToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :recipient, :string
    add_column :reviews, :street_name, :string
    add_column :reviews, :city, :string
    add_column :reviews, :postal_code, :string
    add_column :reviews, :country_code, :string
    add_column :reviews, :lat, :float
    add_column :reviews, :lng, :float
  end
end
