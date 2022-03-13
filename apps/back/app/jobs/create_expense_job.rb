class CreateExpenseJob < ApplicationJob
  queue_as :default

  def perform(expense)

    puts "Calling Slack API for #{expense.offer.name}"

    if Rails.env != "development"
      notifier = Slack::Notifier.new "https://hooks.slack.com/services/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" do
        defaults username: "AgriVillage"
      end

      footer_env = Rails.env == "production" ? 'AgriVillage - Production' : 'AgriVillage - Staging'

      attachment = {
        fallback: "<!channel> Une nouvelle dépense vient d'être déposée.",
        color: "good",
        pretext: "Une nouvelle dépense vient d'être déposée.",
        author_name: expense.offer.farmer.full_name,
        author_link: "https://api.agrivillage.fr/admin/farmers/#{expense.offer.farmer.user.id}",
        title: expense.offer.name,
        title_link: "https://api.agrivillage.fr/admin/expenses/#{expense.id}",
        fields: [
          {
            title: "Nom de l'offre",
            value: expense.offer.name,
            short: true
          },
          {
            title: "Responsable",
            value: "#{expense.responsable}",
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
