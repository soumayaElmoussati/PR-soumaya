class CreateActivityBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :activity_bookings do |t|
      t.integer :status
      t.integer :people_count
      t.date :arrival_date
      t.date :departure_date
      t.integer :total
      t.integer :comission_fee, default: 0
      t.string :promo_code
      t.references :client, foreign_key: true
      t.references :activity, foreign_key: true

      t.timestamps
    end
  end
end
