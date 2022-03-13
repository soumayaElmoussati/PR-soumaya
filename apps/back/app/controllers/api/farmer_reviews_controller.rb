class Api::FarmerReviewsController < ApiController
  protect_from_forgery prepend: true

    before_action :set_farmer_review, only: [:show, :edit, :update]

    def new
      @farmer_review = FarmerReview.new
      format.json { render json: @review, status: :ok }
    end
  
    def create
      @farmer_review = FarmerReview.new(farmer_review_params)
      @booking = Booking.find(@farmer_review.booking_id)
      @farmer_review.first_name = @booking.offer.farmer.user.first_name
      @farmer_review.last_name = @booking.offer.farmer.user.last_name
      respond_to do |format|
        if @farmer_review.save!
          format.json { render template: 'farmer_reviews/show', status: :created }
        else
          format.json { render json: @farmer_review.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit
    end

    def update
    	respond_to do |format|
      	if @farmer_review.update!(farmer_review_params)
          format.json { render template: 'farmer_reviews/show', status: :ok }
        else
          format.json { render json: @farmer_review.errors, status: :unprocessable_entity }
        end
      end
    end

    def show
    	respond_to do |format|
      	format.json { render template: 'farmer_reviews/show', status: :ok }
      end
    end

		private

		def set_farmer_review
			@farmer_review = FarmerReview.find(params[:id])
		end

		def farmer_review_params
      permitted_params = params.require(:farmer_review).permit(
        :first_name,
        :last_name,
        :state,
				:comment,
				:booking_id,
        :cleanliness,
        :communication,
        :respect,
        :experience,
        :welcome
      )

      permitted_params
    end
end
