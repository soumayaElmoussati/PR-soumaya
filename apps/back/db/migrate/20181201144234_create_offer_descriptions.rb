class CreateOfferDescriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :offer_descriptions do |t|
      t.string :food
      t.string :farmers
      t.string :activities
      t.references :offer
    end
  end
end
