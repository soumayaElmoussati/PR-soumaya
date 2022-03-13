class CreateCloudPicture < ActiveRecord::Migration[5.2]
  def change
    create_table :cloud_pictures do |t|
      t.references :offer, foreign_key: true
      t.integer :order, default: 1
      t.string :public_id
      t.string :url

      t.timestamps
    end
  end
end
