class ExternalActivityBooking < ApplicationRecord
  belongs_to :activity

  validates :activity, :start, :end, presence: true

  def self.fetch_for_activity(activity)
    fetch_external_activity_bookings = []

    activity.icalendar_urls.each do |url|
      begin
        external_events_ical = Net::HTTP.get(URI.parse(url))
        cals = Icalendar::Calendar.parse(external_events_ical)
        cals.each do |cal|
          cal.events.each do |event|
            fetch_external_activity_bookings.push(event)
            ExternalActivityBooking.find_or_initialize_by(uid: event.uid.to_s, activity_id: activity.id).update(start: event.dtstart.to_s, end: event.dtend.to_s, source: url)
          end
        end
      rescue StandardError => exception
        puts "Error fetching Icalendar Url #{url} => #{exception.class}, #{exception.message}"
      end
    end

    activity.reload
    existing_bookings = activity.external_activity_bookings.where.not(source: 'manual')

    external_bookings_uids_to_delete = existing_bookings.map(&:uid) - fetch_external_activity_bookings.map { |e| e.uid.to_s }
    ExternalActivityBooking.where(uid: external_bookings_uids_to_delete).destroy_all
  end

end
