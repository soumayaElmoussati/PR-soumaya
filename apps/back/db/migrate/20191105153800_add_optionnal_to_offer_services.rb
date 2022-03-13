class AddOptionnalToOfferServices < ActiveRecord::Migration[5.2]
  def change
    add_column :offer_services, :breakfastopt, :boolean, default: false
    add_column :offer_services, :linensopt, :boolean, default: false
    add_column :offer_services, :cleaningopt, :boolean, default: false
  end
end
