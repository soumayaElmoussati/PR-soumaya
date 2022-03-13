class CreateOfferJob < ApplicationJob
  queue_as :default

  def perform(offer)

    puts "Calling Slack API for #{offer.name}"

    if Rails.env != "development"
      notifier = Slack::Notifier.new "https://hooks.slack.com/services/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" do
        defaults username: "AgriVillage"
      end

      footer_env = Rails.env == "production" ? 'AgriVillage - Production' : 'AgriVillage - Staging'

      attachment = {
        fallback: "<!channel> Une nouvelle offre vient d'être déposée.",
        color: "good",
        pretext: "Une nouvelle offre vient d'être déposée.",
        author_name: offer.farmer.full_name,
        author_link: "https://api.agrivillage.fr/admin/farmers/#{offer.farmer.user.id}",
        title: offer.name,
        title_link: "https://api.agrivillage.fr/admin/offers/#{offer.id}",
        fields: [
          {
            title: "Nom de l'offre",
            value: offer.name,
            short: true
          },
          {
            title: "Ville",
            value: "#{offer.address.city}, #{offer.address.postal_code}",
            short: true
          }
        ],
        footer: footer_env,
        ts: Time.now.to_i
      }

      notifier.post attachments: [attachment], icon_url: "https://www.agrivillage.fr/icon.png"
    end

    sleep 2

    puts "Done ! Notification send"

  end
end
