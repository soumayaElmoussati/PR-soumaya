class Api::ReviewsController < ApiController
  protect_from_forgery prepend: true

    before_action :set_review, only: [:show, :edit, :update, :add_pictures]

    def new
      @review = Review.new
      format.json { render json: @review, status: :ok }
    end
  
    def create
      @review = Review.new(review_params)
      @booking = Booking.find(@review.booking_id)
      @review.stay_date = @booking.arrival_date
      @review.residence_type = @booking.offer.residence_type
      @review.first_name = @booking.client.user.first_name
      @review.last_name = @booking.client.user.last_name
      respond_to do |format|
        if @booking.reviews.length < 1 && @review.save!
          format.json { render template: 'reviews/show', status: :created }
        else
          format.json { render json: @review.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit
    end

    def update
    	respond_to do |format|
      	if @review.update!(review_params)
          format.json { render template: 'reviews/show', status: :ok }
        else
          format.json { render json: @review.errors, status: :unprocessable_entity }
        end
      end
    end

    def show
    	respond_to do |format|
      	format.json { render template: 'reviews/show', status: :ok }
      end
    end

    # POST /add_pictures
  	# POST /add_pictures.json
		def add_pictures
			respond_to do |format|
				if pictures_params.count > 0
					pictures_params.each do |picture|
						@picture = @review.pictures.create()
						@picture.update_column(:image, "image/upload/#{picture[:public_id]}")
					end

					@review = Review.find(params[:id])
					format.json { render template: 'reviews/show', status: :created }
				else
					format.json { render json: @review.errors, status: :unprocessable_entity }
				end
			end
		end

		def remove_picture
			respond_to do |format|
				@review = Review.find(params[:id])
				@picture = @review.pictures.find(params[:picture_id])
				@picture.destroy
				format.html { redirect_to offers_url, notice: 'Picture was successfully destroyed.' }
				format.json { head :no_content }
			end
		end

		# POST /replace_pictures
  	# POST /replace_pictures.json
		def replace_pictures
			respond_to do |format|
				@review = Review.find(params[:id])
				@review.cloud_review_pictures = []
				pictures_params.each do |picture|
					@picture = @review.cloud_review_pictures.create()
					@picture.update_column(:order, picture[:order])
					@picture.update_column(:public_id, picture[:public_id])
					@picture.update_column(:url, picture[:url])
				end
				format.json { render json: {}, status: :created }
			end
		end

		private

		def set_review
			@review = Review.find(params[:id])
		end

    def pictures_params
      permitted_params = params.require(:pictures)
      permitted_params
    end

		def review_params
      permitted_params = params.require(:review).permit(
        :first_name,
        :last_name,
        :star,
        :state,
        :residence_type,
				:comment,
				:stay_date,
				:booking_id,
        :situation,
        :lodging,
        :activity,
        :services,
        :contact,
        :process,
        :trip_note,
        :reference,
        :recipient,
        :street_name,
        :city,
        :postal_code,
        :country_code,
        :lat,
        :lng,
        cloud_review_pictures: [
          :review_id,
          :order,
          :public_id,
          :url
        ]
      )

      if permitted_params[:cloud_review_pictures]
        cloud_review_pictures = @review.nil? || @review.cloud_review_pictures.nil? ? CloudReviewPicture.new : @review.cloud_review_pictures
        cloud_review_pictures.build(permitted_params[:cloud_review_pictures])
        permitted_params[:cloud_review_pictures] = cloud_review_pictures
      end

      permitted_params
    end
end
