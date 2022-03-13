class AddPictureTypeToCloudPictures < ActiveRecord::Migration[5.2]
  def change
    add_column :cloud_pictures, :picture_type, :string, default: "offer"
  end
end
