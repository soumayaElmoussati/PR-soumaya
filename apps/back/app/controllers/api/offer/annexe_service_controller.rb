class Api::Offer::AnnexeServiceController < ApiController
  protect_from_forgery prepend: true

  before_action :set_offer, only: [:create, :update, :destroy]
  before_action :set_annexe_service, only: [:update, :destroy]

  def create
    @annexe_service = AnnexeService.new(annexe_service_params)
    @annexe_service.offer = @offer

    respond_to do |format|
      if @annexe_service.save
        set_offer
        format.json { render template: 'offers/show', status: :created }
      else
        format.json { render json: { errors: @annexe_service.errors }, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @annexe_service.update(annexe_service_params)
        set_offer
        format.json { render template: 'offers/show', status: :ok }
      else
        format.json { render json: { errors: @annexe_service.errors }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @annexe_service.destroy
    respond_to do |format|
      set_offer
      format.json { render template: 'offers/show', status: :ok }
    end
  end

  private
    def set_offer
      @offer = Offer.find(params[:offer_id])
    end
    
    def set_annexe_service
      @annexe_service = @offer.annexe_services.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def annexe_service_params
      permitted_params = params.require(:annexe_service).permit(
        :name,
        :price,
        :unity,
        :description
      )
    end
end
