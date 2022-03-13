class Api::Offer::PriceDiscountController < ApiController
  protect_from_forgery prepend: true

  before_action :set_offer, only: [:create, :update, :destroy]
  before_action :set_price_discount, only: [:update, :destroy]

  def create
    @price_discount = OfferPriceDiscount.new(offer_price_discount_params)
    @price_discount.offer = @offer

    respond_to do |format|
      if @price_discount.save
        set_offer
        format.json { render template: 'offers/show', status: :created }
      else
        format.json { render json: { errors: @price_discount.errors }, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @price_discount.update(offer_price_discount_params)
        set_offer
        format.json { render template: 'offers/show', status: :ok }
      else
        format.json { render json: { errors: @price_discount.errors }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @price_discount.destroy
    respond_to do |format|
      set_offer
      format.json { render template: 'offers/show', status: :ok }
    end
  end

  private
    def set_offer
      @offer = Offer.find(params[:offer_id])
    end

    def set_price_discount
      @price_discount = @offer.offer_price_discounts.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offer_price_discount_params
      permitted_params = params.require(:offer_price_discount).permit(
        :percentage_discount,
        :min_nights
      )
    end
end
