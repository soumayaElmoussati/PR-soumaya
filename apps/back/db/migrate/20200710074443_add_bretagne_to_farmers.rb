class AddBretagneToFarmers < ActiveRecord::Migration[5.2]
  def change
    add_column :farmers, :agriculteur_de_bretagne, :boolean, default: false
  end
end
