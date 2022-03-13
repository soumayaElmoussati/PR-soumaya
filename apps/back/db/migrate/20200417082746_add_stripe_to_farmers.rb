class AddStripeToFarmers < ActiveRecord::Migration[5.2]
  def change
    add_column :farmers, :stripe_user_id, :string
  end
end
