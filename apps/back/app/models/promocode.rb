class Promocode < ApplicationRecord

  before_create :set_code

  validates :code, uniqueness: true

  def set_code
    self.code = self.code.upcase
  end
end
