class CreateOfferSettlements < ActiveRecord::Migration[5.2]
  def change
    create_table :offer_settlements do |t|
      t.references :offer, foreign_key: true
      t.boolean :baby_suitable, default: false
      t.boolean :child_suitable, default: false
      t.boolean :smooking_allowed, default: false
      t.boolean :parties_allowed, default: false
      t.string :additional_rules
    end
  end
end
