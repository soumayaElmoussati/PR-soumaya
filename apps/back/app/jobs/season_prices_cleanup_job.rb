class SeasonPricesCleanupJob < ApplicationJob
  queue_as :default

  def perform(*args)
    p "Cleaning price periods"

    OfferPricePeriod.cleanup_past

    sleep 2

    p "Done"
    
  end
end
