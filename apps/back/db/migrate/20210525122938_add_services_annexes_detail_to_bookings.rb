class AddServicesAnnexesDetailToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :bike_rent_nb, :integer
    add_column :bookings, :bike_rent_price, :integer
    add_column :bookings, :bike_rent_msg, :text
    add_column :bookings, :breakfast_nb, :integer
    add_column :bookings, :breakfast_price, :integer
    add_column :bookings, :breakfast_msg, :text
    add_column :bookings, :packed_lunch_nb, :integer
    add_column :bookings, :packed_lunch_price, :integer
    add_column :bookings, :packed_lunch_msg, :text
    add_column :bookings, :cooking_workshop_nb, :integer
    add_column :bookings, :cooking_workshop_price, :integer
    add_column :bookings, :cooking_workshop_msg, :text
    add_column :bookings, :serenity_nb, :integer
    add_column :bookings, :serenity_price, :integer
    add_column :bookings, :serenity_msg, :text
    add_column :bookings, :spa_nb, :integer
    add_column :bookings, :spa_price, :integer
    add_column :bookings, :spa_msg, :text
    add_column :bookings, :car_rent_nb, :integer
    add_column :bookings, :car_rent_price, :integer
    add_column :bookings, :car_rent_msg, :text
    add_column :bookings, :station_ride_nb, :integer
    add_column :bookings, :station_ride_price, :integer
    add_column :bookings, :station_ride_msg, :text
    add_column :bookings, :animal_space_nb, :integer
    add_column :bookings, :animal_space_price, :integer
    add_column :bookings, :animal_space_msg, :text
    add_column :bookings, :host_table_nb, :integer
    add_column :bookings, :host_table_price, :integer
    add_column :bookings, :host_table_msg, :text
  end
end
