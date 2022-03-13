class FarmerReview < ApplicationRecord
  belongs_to :booking

  before_create :set_full_name

  validates :first_name, :last_name, :cleanliness, :communication, :respect, :experience, :welcome, :state, :comment, presence: true

  enum state: [
    :draft,
    :pending_validation,
    :validate
  ], _prefix: :reviews

  def set_full_name
    self.full_name = "#{first_name.capitalize} #{last_name.upcase}"
  end
end
