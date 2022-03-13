class OfferRoom < ApplicationRecord
  belongs_to :offer

  validates :simple_bed, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }

  validates :double_bed, presence: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }
end
