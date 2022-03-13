class AddLamaToAnimals < ActiveRecord::Migration[5.2]
  def change
    add_column :offer_animals, :lama, :boolean, default: false
  end
end
