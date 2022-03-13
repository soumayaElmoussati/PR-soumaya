class AddDescriptionToFarmers < ActiveRecord::Migration[5.2]
  def change
    add_column :farmers, :description, :text
  end
end
