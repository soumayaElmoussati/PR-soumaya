class CreateCloudOfferPictures < ActiveRecord::Migration[5.2]
  def change
    create_table :cloud_offer_pictures do |t|
      t.string :public_id
      t.string :url
      t.integer :order, default: 1
      t.references :offer, foreign_key: true
      t.timestamps
    end
  end
end
