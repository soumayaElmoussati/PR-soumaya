class Api::V2::MetricsController < ApiController
  protect_from_forgery prepend: true

  api :GET, '/metrics'
  def metrics
    @prices = Offer.find_by_sql('select MAX(price_per_person) as max, MIN(price_per_person) as min from offers where state = 2').first

    respond_to do |format|
      format.json { render template: 'metrics/metrics', status: :ok }
    end
  end
end
