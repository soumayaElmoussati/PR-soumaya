class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :name
      t.string :street_name
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :country_code
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
