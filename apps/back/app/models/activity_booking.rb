require 'slack-notifier'

class ActivityBooking < ApplicationRecord
  belongs_to :client
  belongs_to :activity

  COMMISSION = 300

  enum status: [
    :pending,
    :confirmed,
    :declined,
    :cancelled,
    :finished,
    :payed,
    :withdraw
  ]

  validates :client, presence: true
  validates :activity, presence: true
  validates :people_count, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1
  }

  scope :to_display, -> { where(status: [:confirmed, :finished]) }

  before_save :update_calculus
  before_create :set_depart
  after_create :notify_slack

  def set_depart
    self.departure_date = self.arrival_date + 1
  end
  # Returns the number of days between the arrival date and the departure date
  def days_offset
    days = (self.departure_date.to_datetime - self.arrival_date.to_datetime).to_i
    return days
  end

  def total_activity_calculus

    base_price = self.activity.price_per_person * self.days_offset

    if self.people_count > self.activity.people_count

      exceeding_people_count = self.people_count - self.activity.people_count
      extra_people_price = exceeding_people_count * self.activity.additional_traveler_price * self.days_offset

      return base_price + extra_people_price
    else
      return base_price
    end

  end

  def commission_calculus
    com = (COMMISSION).to_i
    return com
  end

  def total_calculus
    total = self.total_activity_calculus + self.commission_calculus
  end

  def notify_slack
    if Rails.env != "development"
      notifier = Slack::Notifier.new "https://hooks.slack.com/services/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" do
        defaults username: "AgriVillage"
      end

      footer_env = Rails.env == "production" ? 'AgriVillage - Production' : 'AgriVillage - Staging'

      attachment = {
        fallback: "<!channel> Une nouvelle réservation d'activité vient d'être effectuée.",
        color: "good",
        pretext: "Une nouvelle réservation d'activité vient d'être effectuée.",
        author_name: self.client.full_name,
        author_link: "https://api.agrivillage.fr/admin/clients/#{self.client.user.id}",
        title: self.activity.name,
        title_link: "https://api.agrivillage.fr/admin/activities/#{self.activity.id}",
        fields: [
          {
            title: "Nombre de personnes",
            value: self.people_count,
            short: true
          },
          {
            title: "Date d'arrivée",
            value: self.arrival_date.strftime('%d/%m/%Y'),
            short: true
          },
          {
            title: "Date de départ",
            value: self.departure_date.strftime('%d/%m/%Y'),
            short: true
          },
          {
            title: "Total",
            value: self.total,
            short: true
          }
        ],
        footer: footer_env,
        ts: Time.now.to_i
      }

      notifier.post attachments: [attachment], icon_url: "https://www.agrivillage.fr/icon.png"
    end
  end

  private

  # def dates
  #   if departure_date < DateTime.now
  #     errors.add(:departure_date, "cannot be in the past")
  #   end
  #
  #   if arrival_date < DateTime.now
  #     errors.add(:arrival_date, "cannot be in the past")
  #   end
  #
  #   if departure_date < arrival_date
  #     errors.add(:departure_date, "must be after the arrival date")
  #   end
  # end

  def update_calculus
    self.departure_date = set_depart
    self.comission_fee = commission_calculus
    self.total = total_calculus
  end

end
