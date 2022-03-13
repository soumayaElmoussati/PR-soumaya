class CreateActivitySettlements < ActiveRecord::Migration[5.2]
  def change
    create_table :activity_settlements do |t|
      t.references :activity, foreign_key: true
      t.boolean :baby_suitable, default: false
      t.boolean :child_suitable, default: false
      t.boolean :smooking_allowed, default: false
      t.boolean :parties_allowed, default: false
      t.string :additional_rules
      t.boolean :animals_welcome, default: false
      t.boolean :accessible, default: false
      t.timestamps
    end
  end
end
