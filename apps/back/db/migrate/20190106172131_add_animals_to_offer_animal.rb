class AddAnimalsToOfferAnimal < ActiveRecord::Migration[5.2]
  def change
    add_column :offer_animals, :donkey, :boolean, default: false
    add_column :offer_animals, :snail, :boolean, default: false
    add_column :offer_animals, :horse, :boolean, default: false
  end
end
