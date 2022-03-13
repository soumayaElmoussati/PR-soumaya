class CreateActivityFarmTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :activity_farm_types do |t|
      t.references :activity, foreign_key: true
      t.boolean :breeder, default: false
      t.boolean :cereal, default: false
      t.boolean :horticulturist, default: false
      t.boolean :market_gardener, default: false
      t.boolean :cheese_production, default: false
      t.boolean :winegrower, default: false
      t.boolean :brewer, default: false
      t.boolean :arborist, default: false
      t.boolean :oyster_farmer, default: false
      t.boolean :mushroom_grower, default: false
      t.boolean :beekeeper, default: false
      t.boolean :cider_maker, default: false
      t.boolean :riding_stable, default: false
      t.boolean :agroforestry, default: false
      t.timestamps
    end
  end
end
