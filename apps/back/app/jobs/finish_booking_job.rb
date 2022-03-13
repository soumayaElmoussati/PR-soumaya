class FinishBookingJob < ApplicationJob
  queue_as :default

  def perform(booking)
    puts "Update booking"

    Booking.finish_booking

    sleep 2

    puts "Done ! Booking updated"
  end
end
