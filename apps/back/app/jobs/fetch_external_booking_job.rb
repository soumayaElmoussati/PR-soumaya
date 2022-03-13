class FetchExternalBookingJob < ApplicationJob
  queue_as :default

  def perform(*args)

    puts "Refresh external bookings"

    Offer.fetch_external_bookings

    sleep 2

    puts "Done ! Notification send"

  end
end
