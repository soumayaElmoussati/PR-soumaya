# frozen_string_literal: true

class ExternalBooking < ApplicationRecord
  belongs_to :offer

  validates :offer, :start, :end, presence: true

  scope :available, ->(arrival_date, departure_date){ 
    outside_of(arrival_date, departure_date).not_pending(arrival_date, departure_date) 
  }

  scope :outside_of, ->(arrival_date, departure_date){ 
    where("start <= ? and 'end' >= ?", arrival_date, departure_date) 
  }

  scope :not_pending, ->(arrival_date, departure_date){ 
    where.not("start >= ? and 'end' <= ?", arrival_date, departure_date)
  }

  def self.fetch_for_offer(offer)
    fetched_external_bookings = []
    offer.icalendar_urls.each do |url|
      begin
        external_events_ical = Net::HTTP.get(URI.parse(url))
        cals = Icalendar::Calendar.parse(external_events_ical)
        cals.each do |cal|
          cal.events.each do |event|
            fetched_external_bookings.push(event)
            ExternalBooking.find_or_initialize_by(uid: event.uid.to_s, offer_id: offer.id).update(start: event.dtstart.to_s, end: event.dtend.to_s, source: url)
          end
        end
      rescue StandardError => exception
        puts "Error fetching Icalendar Url #{url} => #{exception.class}, #{exception.message}"
      end
    end
    offer.reload
    existing_bookings = offer.external_bookings.where.not(source: 'manual')

    external_bookings_uids_to_delete = existing_bookings.map(&:uid) - fetched_external_bookings.map { |e| e.uid.to_s }
    ExternalBooking.where(uid: external_bookings_uids_to_delete).destroy_all
  end
end
