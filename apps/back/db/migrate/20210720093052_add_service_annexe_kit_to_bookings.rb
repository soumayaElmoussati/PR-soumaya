class AddServiceAnnexeKitToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :washing_kit_nb, :integer
    add_column :bookings, :washing_kit_price, :integer
    add_column :bookings, :washing_kit_msg, :text
    add_column :bookings, :bbq_nb, :integer
    add_column :bookings, :bbq_price, :integer
    add_column :bookings, :bbq_msg, :text
    add_column :bookings, :riding_lesson_nb, :integer
    add_column :bookings, :riding_lesson_price, :integer
    add_column :bookings, :riding_lesson_msg, :text
    add_column :bookings, :horse_ride_nb, :integer
    add_column :bookings, :horse_ride_price, :integer
    add_column :bookings, :horse_ride_msg, :text
    add_column :bookings, :riding_course_nb, :integer
    add_column :bookings, :riding_course_price, :integer
    add_column :bookings, :riding_course_msg, :text
    add_column :bookings, :riding_introduction_nb, :integer
    add_column :bookings, :riding_introduction_price, :integer
    add_column :bookings, :riding_introduction_msg, :text
    add_column :bookings, :immersion_nb, :integer
    add_column :bookings, :immersion_price, :integer
    add_column :bookings, :immersion_msg, :text
  end
end
