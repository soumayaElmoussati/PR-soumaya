class AddColumnToOfferDescription < ActiveRecord::Migration[5.2]
  def change
    add_column :offer_descriptions, :discovery, :boolean, default: false
    add_column :offer_descriptions, :meeting_animals, :boolean, default: false
    add_column :offer_descriptions, :milking_animals, :boolean, default: false
    add_column :offer_descriptions, :tasting, :boolean, default: false
    add_column :offer_descriptions, :birth_animal, :boolean, default: false
    add_column :offer_descriptions, :stroll, :boolean, default: false
    add_column :offer_descriptions, :harvest, :boolean, default: false
    add_column :offer_descriptions, :craft, :boolean, default: false
  end
end
