class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.datetime :arrival_date
      t.datetime :departure_date
      t.references :offer, foreign_key: true
      t.integer :booking_id
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
