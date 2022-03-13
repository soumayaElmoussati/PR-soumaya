class ActivityDescription < ApplicationRecord
  belongs_to :activity

  validates :farm, length: { maximum: 1500 }
  validates :farmer, length: { maximum: 1500 }
  validates :residence, length: { maximum: 1500 }
  validates :activities, length: { maximum: 1500 }
end
