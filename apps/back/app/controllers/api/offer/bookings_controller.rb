class Api::Offer::BookingsController < ApiController

  skip_before_action :verify_authenticity_token, only: [:refresh]

  before_action :set_bookings, only: [:index]
  before_action :set_offer, only: [:refresh, :ical]
  
  def index
  end

  def refresh
    @offer.fetch_external_bookings

    @offer.reload 

    @bookings = @offer.bookings.to_display
    @external_bookings = @offer.external_bookings

    render template: 'api/offer/bookings/index'
  end

  def ical
    @bookings = @offer.bookings.to_display
    @external_bookings = @offer.external_bookings

    cal = Icalendar::Calendar.new
    cal.prodid = '-//Acme Widgets, Inc.//NONSGML ExportToCalendar//FR'
    cal.version = '2.0'

    filename = "ical #{@offer.name}"
    filename += '.ics'

    @bookings.each do |booking|

      cal.event do |e|
        e.dtstart     = Icalendar::Values::DateTime.new(booking.arrival_date)
        e.dtend       = Icalendar::Values::DateTime.new(booking.departure_date)
        e.summary     = booking.offer.name
        e.description = booking.message
        e.location    = "#{booking.offer.address.street_name} #{booking.offer.address.postal_code} #{booking.offer.address.city}"
      end

    end

    @external_bookings.each do |external_booking|

      cal.event do |e|
        e.dtstart     = Icalendar::Values::DateTime.new(external_booking.start)
        e.dtend       = Icalendar::Values::DateTime.new(external_booking.end)
        e.summary     = external_booking.offer.name
        e.description = external_booking.notes
        e.location    = "#{external_booking.offer.address.street_name} #{external_booking.offer.address.postal_code} #{external_booking.offer.address.city}"
      end

    end

    cal.publish
    send_data cal.to_ical, type: 'text/calendar', disposition: 'attachment', filename: filename
  end

  private

  def set_offer
    @offer = Offer.find(params[:offer_id])
  end

  def set_bookings
    offer = Offer.includes(:bookings, :external_bookings).find(params[:offer_id])

    @bookings = offer.bookings.to_display
    @external_bookings = offer.external_bookings
  end
end