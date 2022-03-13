class AnnexeService < ApplicationRecord
  belongs_to :offer

  validates :name, :price, :description, presence: true
  validates :name, uniqueness: { scope: :offer_id }

end
