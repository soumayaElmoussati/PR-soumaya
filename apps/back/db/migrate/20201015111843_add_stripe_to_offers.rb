class AddStripeToOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :offers, :product_token, :string
  end
end
