class CreateCloudProfilePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :cloud_profile_pictures do |t|
      t.string :public_id
      t.string :url
      t.references :farmer, foreign_key: true
      t.timestamps
    end
  end
end
