class OfferDescriptionsChangeColumnText < ActiveRecord::Migration[5.2]
  def up
    change_column :offer_descriptions, :residence, :text
    change_column :offer_descriptions, :farmer, :text
    change_column :offer_descriptions, :activities, :text
  end

  def down
    change_column :offer_descriptions, :residence, :text
    change_column :offer_descriptions, :farmer, :text
    change_column :offer_descriptions, :activities, :text
  end
end
