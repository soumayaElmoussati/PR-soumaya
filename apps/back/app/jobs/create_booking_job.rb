class CreateBookingJob < ApplicationJob
  queue_as :default

  def perform(booking)

    puts "Calling Slack API for #{booking.client.full_name}"

    if Rails.env != "development"

      notifier = Slack::Notifier.new "https://hooks.slack.com/services/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" do
        defaults username: "AgriVillage"
      end

      footer_env = Rails.env == "production" ? 'AgriVillage - Production' : 'AgriVillage - Staging'

      attachment = {
        fallback: "<!channel> Une nouvelle réservation vient d'être effectuée.",
        color: "good",
        pretext: "Une nouvelle réservation vient d'être effectuée.",
        author_name: booking.client.full_name,
        author_link: "https://api.agrivillage.fr/admin/clients/#{booking.client.user.id}",
        title: booking.offer.name,
        title_link: "https://api.agrivillage.fr/admin/offers/#{booking.offer.id}",
        fields: [
          {
            title: "Nombre de personnes",
            value: booking.people_count,
            short: true
          },
          {
            title: "Date d'arrivée",
            value: booking.arrival_date.strftime('%d/%m/%Y'),
            short: true
          },
          {
            title: "Date de départ",
            value: booking.departure_date.strftime('%d/%m/%Y'),
            short: true
          },
          {
            title: "Total",
            value: booking.total,
            short: true
          }
        ],
        footer: footer_env,
        ts: Time.now.to_i
      }

      notifier.post attachments: [attachment], icon_url: "https://www.agrivillage.fr/icon.png"

      Gibbon::Request.new(api_key: "d158c8f7d0d548603670c8d45421d5b6-us20")
      .lists("0dda707543")
      .members(Digest::MD5.hexdigest(booking.client.user.email))
      .tags
      .create(
        body: {
          tags: [{name:"Client demande de résa", status:"active"}]
        }
      )

    end

    sleep 2

    puts "Done ! Notification send"

  end
end
