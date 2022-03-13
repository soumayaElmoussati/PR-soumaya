class Offer < ApplicationRecord

  default_scope lambda { order(updated_at: :desc) }

  is_impressionable :counter_cache => true, :column_name => :impressions_count

  belongs_to :farmer
  accepts_nested_attributes_for :farmer

  has_one :address
  accepts_nested_attributes_for :address

  has_many :pictures, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :pictures, :allow_destroy => true

  has_many :bookings
  has_many :external_bookings

  has_many :events, dependent: :destroy
  accepts_nested_attributes_for :events, allow_destroy: true

  has_many :offer_rooms, dependent: :destroy
  accepts_nested_attributes_for :offer_rooms, :allow_destroy => true

  has_many :expenses, dependent: :destroy
  accepts_nested_attributes_for :expenses, :allow_destroy => true

  has_many :annexe_services, dependent: :destroy
  accepts_nested_attributes_for :annexe_services, :allow_destroy => true

  has_one :offer_farm_type, dependent: :destroy
  accepts_nested_attributes_for :offer_farm_type, :allow_destroy => true

  has_one :offer_agriculture_type, dependent: :destroy
  accepts_nested_attributes_for :offer_agriculture_type, :allow_destroy => true

  has_one :offer_adjectif, dependent: :destroy
  accepts_nested_attributes_for :offer_adjectif, :allow_destroy => true

  has_one :offer_tag, dependent: :destroy
  accepts_nested_attributes_for :offer_tag, :allow_destroy => true

  has_one :offer_description, dependent: :destroy
  accepts_nested_attributes_for :offer_description, :allow_destroy => true

  has_one :offer_equipment, dependent: :destroy
  accepts_nested_attributes_for :offer_equipment, :allow_destroy => true

  has_one :offer_benefit, dependent: :destroy
  accepts_nested_attributes_for :offer_benefit, :allow_destroy => true

  has_one :offer_animal, dependent: :destroy
  accepts_nested_attributes_for :offer_animal, :allow_destroy => true

  has_one :offer_settlement, dependent: :destroy
  accepts_nested_attributes_for :offer_settlement, :allow_destroy => true

  has_one :offer_price_weekend, dependent: :destroy
  accepts_nested_attributes_for :offer_price_weekend, :allow_destroy => true

  has_many :offer_promotions, dependent: :destroy
  accepts_nested_attributes_for :offer_promotions, allow_destroy: true

  has_many :offer_price_periods, dependent: :destroy
  accepts_nested_attributes_for :offer_price_periods, allow_destroy: true

  has_many :cloud_pictures, dependent: :destroy
  accepts_nested_attributes_for :cloud_pictures, allow_destroy: true

  has_many :cloud_offer_pictures, dependent: :destroy
  accepts_nested_attributes_for :cloud_offer_pictures, allow_destroy: true

  has_many :offer_price_discounts, dependent: :destroy
  accepts_nested_attributes_for :offer_price_discounts, allow_destroy: true

  has_one :offer_service, dependent: :destroy
  accepts_nested_attributes_for :offer_service, allow_destroy: true

  enum state: [
    :draft,
    :pending_validation,
    :published
  ]

  enum residence_type: [
    :entire_house,
    :private_room,
    :guest_room,
    :unusual_room,
    :tiny_house,
    :immersive_house
  ]

  validates :farmer, presence: true

  validates :name,
    presence: true,
    length: { maximum: 200 }

  validates :people_count,
    numericality: {
      greater_or_equal_than: 1,
      only_integer: true
    }

  validates :price_per_person, numericality: {
    only_integer: true
  }

  validates_length_of :icalendar_urls, maximum: 3

  validates_associated :pictures, :expenses, :offer_rooms, :offer_price_periods, :cloud_pictures, :cloud_offer_pictures, :offer_price_discounts, :address, :offer_farm_type, :offer_agriculture_type, :offer_adjectif, :offer_tag, :offer_description, :offer_equipment, :offer_benefit, :offer_animal, :offer_settlement, :annexe_services, :offer_service, :offer_promotions

  before_create :create_slug
  before_save :update_max_people_count, :update_area_code

  before_update :offer_available,
    :if => proc { state_changed? && state_was == "pending_validation" && state == "published" }

  after_create :notify_slack, :offer_deposit

  reverse_geocoded_by "addresses.lat", "addresses.lng"

  scope :with_animals, -> (animals) {
    scope = where(offer_animals: Hash[])
    animals.each do |animal|
      scope = scope.or(where(offer_animals: Hash[animal, true]))
    end

    scope.joins(:offer_animal)
  }

  scope :with_agriculture_types, -> (agriculture_types) {
    scope = where(offer_agriculture_types: Hash[])
    agriculture_types.each do |agriculture_type|
      scope = scope.or(where(offer_agriculture_types: Hash[agriculture_type, true]))
    end

    scope.joins(:offer_agriculture_type)
  }

  scope :with_farm_types, -> (farm_types) {
    scope = where(offer_farm_types: Hash[])
    farm_types.each do |farm_type|
      scope = scope.or(where(offer_farm_types: Hash[farm_type, true]))
    end

    scope.joins(:offer_farm_type)
  }

  scope :with_equipments, -> (equipments) {
    joins(:offer_equipment).where(offer_equipments: Hash[equipments.collect { |v| [v, true] }])
  }

  scope :with_settlements, -> (settlements) {
    joins(:offer_settlement).where(offer_settlements: Hash[settlements.collect { |v| [v, true] }])
  }

  scope :with_activities, -> (activities) {
    scope = where(offer_descriptions: Hash[])
    activities.each do |activity|
      scope = scope.or(where(offer_descriptions: Hash[activity, true]))
    end

    scope.joins(:offer_description)
  }

  scope :with_services, -> (services) {
    scope = where(offer_services: Hash[])
    services.each do |service|
      scope = scope.or(where(offer_services: Hash[service, true]))
    end

    scope.joins(:offer_service)
  }

  # Generate a new slug based on the name of the offer
  def create_slug
    self.slug = self.name.parameterize
  end

  def offer_deposit
    if self.residence_type != 'tiny_house'
      FarmerMailer.with(
        farmer: self.farmer,
        offer: self
      ).offer_deposit.deliver_later
    end
  end

  def offer_available
    if self.residence_type != 'tiny_house'
      FarmerMailer.with(
        farmer: self.farmer,
        offer: self
      ).offer_available.deliver_later
    end
  end

  def self.fetch_external_bookings
    Offer.where(state: :published).each do |offer|
      offer.fetch_external_bookings
    end
  end

  def fetch_external_bookings
    ExternalBooking.fetch_for_offer(self)
  end

  def available?(from, to)
    self.bookings.where('arrival_date <= ? AND departure_date >= ? AND status != ?', to, from, 0).none?
  end

  private

  def notify_slack
    CreateOfferJob.perform_later(self)
  end

  def update_max_people_count
    self.max_people_count = self.additional_max_people + self.people_count
  end

  def update_area_code
    self.address.area_code = self.address.postal_code[0...2]
  end
end
