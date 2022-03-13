class Event < ApplicationRecord
  belongs_to :offer

  enum status: %i[unavailable booked]
end
