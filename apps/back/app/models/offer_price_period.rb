class OfferPricePeriod < ApplicationRecord
  belongs_to :offer
  after_save :cleanup_past
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :dates_validation, if: [Proc.new { |p| p.start_date.present? && p.end_date.present? }]
  validates :price_period, presence: true, numericality: {
    only_integer: true,
    allow_nil: false,
    greater_than_or_equal_to: 0
  }

  validates :min_days, presence: true, numericality: {
    only_integer: true,
    allow_nil: false,
    greater_than_or_equal_to: 0
  }

  def cleanup_past

    self.offer.offer_price_periods.each do |period|
      if period.end_date < Date.today
        period.delete
      end
    end
    
  end

  private

  def dates_validation
    if start_date.to_date > end_date.to_date
      errors.add(:start_date, "must be before the end date")
      errors.add(:end_date, "must be after the start date")
    end

    overlaps = false
    offer = self.offer

    offer.offer_price_periods.each do |period|
      if self != period
        # Change the period's year to the current
        periodStartDate = period.start_date.change(:year => Time.now.year)
        periodEndDate = period.end_date.change(:year => Time.now.year)
        otherPeriodStartDate = self.start_date.change(:year => Time.now.year)
        otherPeriodEndDate = self.end_date.change(:year => Time.now.year)

        overlap_with_dates = (period.start_date.to_date..period.end_date.to_date).overlaps?(self.start_date.to_date..self.end_date.to_date)
        if overlap_with_dates
          overlaps = true
        end
      end
    end

    if overlaps
      errors.add(:base, "Price periods cannot overlap other price periods")
    end
  end
end
