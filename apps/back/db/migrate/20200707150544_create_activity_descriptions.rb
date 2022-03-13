class CreateActivityDescriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :activity_descriptions do |t|
      t.references :activity, foreign_key: true
      t.string :residence
      t.string :farmer
      t.string :activities
      t.string :farm
      t.boolean :discovery, default: false
      t.boolean :meeting_animals, default: false
      t.boolean :milking_animals, default: false
      t.boolean :tasting, default: false
      t.boolean :birth_animal, default: false
      t.boolean :stroll, default: false
      t.boolean :harvest, default: false
      t.boolean :craft, default: false
      t.timestamps
    end
  end
end
