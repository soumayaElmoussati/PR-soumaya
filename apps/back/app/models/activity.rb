class Activity < ApplicationRecord
  default_scope { order(created_at: :desc) }

  belongs_to :farmer
  accepts_nested_attributes_for :farmer

  has_many :activity_bookings
  has_many :external_activity_bookings

  has_one :activity_address
  accepts_nested_attributes_for :activity_address

  has_one :activity_farm_type, dependent: :destroy
  accepts_nested_attributes_for :activity_farm_type, :allow_destroy => true

  has_one :activity_agriculture_type, dependent: :destroy
  accepts_nested_attributes_for :activity_agriculture_type, :allow_destroy => true

  has_one :activity_tag, dependent: :destroy
  accepts_nested_attributes_for :activity_tag, :allow_destroy => true

  has_one :activity_animal, dependent: :destroy
  accepts_nested_attributes_for :activity_animal, :allow_destroy => true

  has_one :activity_settlement, dependent: :destroy
  accepts_nested_attributes_for :activity_settlement, :allow_destroy => true

  has_one :activity_description, dependent: :destroy
  accepts_nested_attributes_for :activity_description, :allow_destroy => true

  has_many :pictures, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :pictures, :allow_destroy => true

  has_many :cloud_activity_pictures, dependent: :destroy
  accepts_nested_attributes_for :cloud_activity_pictures, allow_destroy: true

  enum state: [
    :draft,
    :pending_validation,
    :published
  ]

  validates :farmer, presence: true

  validates :name, presence: true, length: { maximum: 200 }

  validates_associated :pictures, :cloud_activity_pictures, :activity_address, :activity_farm_type, :activity_agriculture_type, :activity_tag, :activity_animal, :activity_settlement, :activity_description

  before_create :create_slug
  before_update :create_slug
  before_save :update_max_people_count, :update_area_code
  after_create :notify_slack

  reverse_geocoded_by "activity_addresses.lat", "activity_addresses.lng"

  # Generate a new slug based on the name of the activity
  def create_slug
    self.slug = self.name.parameterize
  end

  def self.fetch_external_activity_bookings
    Activity.where(state: :published).each do |activity|
      activity.fetch_external_activity_bookings
    end
  end

  def fetch_external_activity_bookings
    ExternalActivityBooking.fetch_for_activity(self)
  end

  def notify_slack
    if Rails.env != "development"
      notifier = Slack::Notifier.new "https://hooks.slack.com/services/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" do
        defaults username: "AgriVillage"
      end

      footer_env = Rails.env == "production" ? 'AgriVillage - Production' : 'AgriVillage - Staging'

      attachment = {
        fallback: "<!channel> Une nouvelle activité vient d'être déposée.",
        color: "good",
        pretext: "Une nouvelle activité vient d'être déposée.",
        author_name: self.farmer.full_name,
        author_link: "https://api.agrivillage.fr/admin/farmers/#{self.farmer.user.id}",
        title: self.name,
        title_link: "https://api.agrivillage.fr/admin/activities/#{self.id}",
        fields: [
          {
            title: "Nom de l'activité",
            value: self.name,
            short: true
          },
          {
            title: "Ville",
            value: "#{self.activity_address.city}, #{self.activity_address.postal_code}",
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

  def update_max_people_count
    self.max_people_count = self.additional_max_people + self.people_count
  end

  def update_area_code
    self.activity_address.area_code = self.activity_address.postal_code[0...2]
  end

end
