class Api::Offer::PricePeriodController < ApiController
  protect_from_forgery prepend: true

  before_action :set_offer, only: [:create, :update, :destroy]
  before_action :set_price_period, only: [:update, :destroy]

  def create
    @price_period = OfferPricePeriod.new(offer_price_period_params)
    @price_period.offer = @offer

    respond_to do |format|
      if @price_period.save
        set_offer
        format.json { render template: 'offers/show', status: :created }
      else
        format.json { render json: { errors: @price_period.errors }, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @price_period.update(offer_price_period_params)
        set_offer
        format.json { render template: 'offers/show', status: :ok }
      else
        format.json { render json: { errors: @price_period.errors }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @price_period.destroy
    respond_to do |format|
      set_offer
      format.json { render template: 'offers/show', status: :ok }
    end
  end

  private
    def set_offer
      @offer = Offer.find(params[:offer_id])
    end
    
    def set_price_period
      @price_period = @offer.offer_price_periods.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offer_price_period_params
      permitted_params = params.require(:offer_price_period).permit(
        :start_date,
        :end_date,
        :min_days,
        :use_discount,
        :price_period
      )
    end
end
