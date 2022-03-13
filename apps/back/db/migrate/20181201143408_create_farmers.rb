class CreateFarmers < ActiveRecord::Migration[5.2]
  def change
    create_table :farmers do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
