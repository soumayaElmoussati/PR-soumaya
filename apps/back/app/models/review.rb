class Review < ApplicationRecord
  belongs_to :booking

  has_many :pictures, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :pictures, :allow_destroy => true

  has_many :cloud_review_pictures, dependent: :destroy
  accepts_nested_attributes_for :cloud_review_pictures, allow_destroy: true

  validates :first_name, :last_name, :star, :comment, :stay_date, :residence_type, :situation, :lodging, :activity, :services, :contact, :process, :reference, presence: true

  validates_associated :pictures, :cloud_review_pictures

  geocoded_by :full_address, :latitude  => :lat, :longitude => :lng
  after_validation :geocode, :if => proc { street_name_changed? || postal_code_changed? || city_changed? || country_code_changed? || lat_changed? || lng_changed? }

  before_create :set_full_name

  enum residence_type: [
    :entire_house,
    :private_room,
    :guest_room,
    :unusual_room,
    :tiny_house,
    :immersive_house
  ]

  enum state: [
    :draft,
    :pending_validation,
    :validate
  ], _prefix: :reviews

  def set_full_name
    self.full_name = "#{first_name.capitalize} #{last_name.upcase}"
  end

  def city=(val)
    write_attribute(:city, (val.downcase).capitalize) unless val.nil?
  end

  def country_code=(val)
    write_attribute(:country_code, val.upcase) unless val.nil?
  end

  def full_address
    [street_name, postal_code, city, country_code].compact.join(', ')
  end

end
