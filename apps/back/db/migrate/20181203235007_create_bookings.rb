class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.integer :status, defualt: 0
      t.references :client, foreign_key: true
      t.references :offer, foreign_key: true
      t.integer :people_count
      t.datetime :arrival_date
      t.datetime :departure_date
      t.integer :total

      t.timestamps
    end
  end
end
