class CreateOfferBenefits < ActiveRecord::Migration[5.2]
  def change
    create_table :offer_benefits do |t|
      t.boolean :cleaning_kit
      t.boolean :toilet_paper
      t.boolean :soap
      t.boolean :household_linen
      t.references :offer, foreign_key: true

      t.timestamps
    end
  end
end
