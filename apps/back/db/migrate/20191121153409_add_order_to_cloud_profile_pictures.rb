class AddOrderToCloudProfilePictures < ActiveRecord::Migration[5.2]
  def change
    add_column :cloud_profile_pictures, :order, :integer, default: 1
  end
end
