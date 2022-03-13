class MigrateDataCloudPicture < ActiveRecord::Migration[5.2]
  def up
    Offer.all.each do |offer|
      if offer.pictures.length > 0
        ocp = CloudPicture.create(offer: offer)
        offer.pictures.each do |old_picture|
          ocp.update_column(:order, old_picture.order)
          ocp.update_column(:public_id, old_picture.image.identifier[13..-1])
          ocp.update_column(:url, "https://res.cloudinary.com/agrivillage/image/upload/" + old_picture.image.identifier[13..-1])
          ocp.update_column(:created_at, old_picture.created_at)
          ocp.update_column(:offer_id, old_picture.imageable_id)
        end
      end
    end
  end

  def down
    CloudPicture.delete_all
  end
end
