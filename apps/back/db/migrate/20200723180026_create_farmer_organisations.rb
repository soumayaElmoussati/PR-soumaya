class CreateFarmerOrganisations < ActiveRecord::Migration[5.2]
  def change
    create_table :farmer_organisations do |t|
      t.boolean :adb, default: false
      t.boolean :bbc, default: false
      t.boolean :fairefrance, default: false
      t.references :farmer, foreign_key: true
      t.timestamps
    end
  end
end
