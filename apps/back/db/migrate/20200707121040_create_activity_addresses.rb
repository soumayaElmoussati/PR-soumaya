class CreateActivityAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :activity_addresses do |t|
      t.string :name
      t.string :street_name
      t.string :city
      t.string :postal_code
      t.string :country_code
      t.float :lat
      t.float :lng
      t.references :activity, foreign_key: true
      t.string :area_code

      t.timestamps
    end
  end
end
