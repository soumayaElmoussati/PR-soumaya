class AddAccessibleAndAnimalsWelcomeSettlement < ActiveRecord::Migration[5.2]
  def change
    add_column :offer_settlements, :animals_welcome, :boolean, default: false
    add_column :offer_settlements, :accessible, :boolean, default: false
  end
end
