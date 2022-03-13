class CreateAnnexeServices < ActiveRecord::Migration[5.2]
  def change
    create_table :annexe_services do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.references :offer, foreign_key: true

      t.timestamps
    end
  end
end
