class UpdateOfferDescriptionColumns < ActiveRecord::Migration[5.2]
  def change
    rename_column :offer_descriptions, :food, :residence
    rename_column :offer_descriptions, :farmers, :farmer

    add_column :offer_descriptions, :farm, :string
  end
end
