class CreateExternalBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :external_bookings do |t|
      t.references :offer, foreign_key: true
      t.string :uid, null: false
      t.datetime :start, null: false
      t.datetime :end, null: false
      t.string :source

      t.timestamps
    end
    add_index :external_bookings, :uid, unique: true

  end
end
