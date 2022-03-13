class AddOffersToAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :offer_id, :integer
  end
end
