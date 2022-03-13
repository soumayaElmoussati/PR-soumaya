class ActivityAddress < ApplicationRecord
  belongs_to :activity

  validates :street_name, presence: true
  validates :postal_code, presence: true
  validates :city, presence: true
  validates :country_code, presence: true, length: { is: 2 }
  validates :lat, presence: true
  validates :lng, presence: true

  geocoded_by :full_address, :latitude  => :lat, :longitude => :lng
  after_validation :geocode, :if => proc { street_name_changed? || postal_code_changed? || city_changed? || country_code_changed? || lat_changed? || lng_changed? }

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
