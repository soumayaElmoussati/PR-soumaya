class OfferPriceWeekend < ApplicationRecord
  belongs_to :offer

  validates :price, numericality: {
    only_integer: true,
    allow_nil: true
  }
end
