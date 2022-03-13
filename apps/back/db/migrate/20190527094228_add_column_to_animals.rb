class AddColumnToAnimals < ActiveRecord::Migration[5.2]
  def change
    add_column :offer_animals, :bee, :boolean, default: false
  end
end
