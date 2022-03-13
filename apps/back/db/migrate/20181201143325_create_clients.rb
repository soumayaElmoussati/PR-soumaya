class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.references :user, foreign_key: true
      t.boolean :solvent, default: true

      t.timestamps
    end
  end
end
