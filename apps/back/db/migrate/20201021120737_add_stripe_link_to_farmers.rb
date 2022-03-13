class AddStripeLinkToFarmers < ActiveRecord::Migration[5.2]
  def change
    add_column :farmers, :stripe_link, :string
  end
end
