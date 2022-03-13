class OfferPriceDiscount < ApplicationRecord
  belongs_to :offer

  validates :percentage_discount, numericality: {
    only_integer: true,
    less_than_or_equal_to: 100,
    allow_blank: true
  }

  validates :min_nights, numericality: {
    only_integer: true,
    allow_nil: true,
    greater_than_or_equal_to: 0
  }
end
