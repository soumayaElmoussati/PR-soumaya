class CreateOfferRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :offer_rooms do |t|
      t.references :offer, foreign_key: true
      t.integer :simple_bed, default: 0
      t.integer :double_bed, default: 0
      t.boolean :private_bathroom, default: false
    end
  end
end
