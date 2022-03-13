class OfferService < ApplicationRecord
  belongs_to :offer

  # Returns the sum of all the services
  def total
    breakfast = self.breakfast ? self.breakfast_price : 0
    linens = self.linens ? self.linens_price : 0
    cleaning = self.cleaning ? self.cleaning_price : 0
    host_table = self.host_table ? self.host_table_price : 0

    return linens + cleaning + breakfast + host_table
  end
end
