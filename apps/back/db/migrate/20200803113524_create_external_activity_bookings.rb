class CreateExternalActivityBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :external_activity_bookings do |t|
      t.string :uid
      t.datetime :start
      t.datetime :end
      t.string :source
      t.text :notes
      t.references :activity, foreign_key: true

      t.timestamps
    end
  end
end
