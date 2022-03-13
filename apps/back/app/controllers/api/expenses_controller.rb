class Api::ExpensesController < ApiController
    protect_from_forgery prepend: true

    before_action :set_expense, only: [:show, :edit, :update, :add_pictures]

    def index
			@offer = Offer.find(params[:offer_id])
			@expenses = Expense.where(offer_id: @offer.id)

			respond_to do |format|
				format.json { render template: 'expenses/index', status: :ok }
			end
    end

    def edit
    end

    def create
      @expense = Expense.new(expense_params)
      @offer = Offer.find(@expense.offer_id)
      @expense.offer = @offer

      respond_to do |format|
        if @expense.save!
          format.json { render template: 'expenses/show', status: :created }
        else
          format.json { render json: @expense.errors, status: :unprocessable_entity }
        end
      end
    end
    

    def update
    	respond_to do |format|
      	if @expense.update!(expense_params)
          format.json { render template: 'expenses/show', status: :ok }
        else
          format.json { render json: @expense.errors, status: :unprocessable_entity }
        end
      end
    end

    def show
      @expense = Expense.find(params[:id])
      
    	respond_to do |format|
      	format.json { render template: 'expenses/show', status: :ok }
      end
    end

    # POST /add_pictures
  	# POST /add_pictures.json
		def add_pictures
			respond_to do |format|
				if pictures_params.count > 0
					pictures_params.each do |picture|
						@picture = @expense.pictures.create()
						@picture.update_column(:image, "image/upload/#{picture[:public_id]}")
					end

					@expense = Expense.find(params[:id])
					format.json { render template: 'expenses/show', status: :created }
				else
					format.json { render json: @expense.errors, status: :unprocessable_entity }
				end
			end
		end

		def remove_picture
			respond_to do |format|
				@expense = Expense.find(params[:id])
				@picture = @expense.pictures.find(params[:picture_id])
				@picture.destroy
				format.html { redirect_to offers_url, notice: 'Picture was successfully destroyed.' }
				format.json { head :no_content }
			end
		end

		# POST /replace_pictures
  	# POST /replace_pictures.json
		def replace_pictures
			respond_to do |format|
				@expense = Expense.find(params[:id])
				@expense.cloud_expense_pictures = []
				pictures_params.each do |picture|
					@picture = @expense.cloud_expense_pictures.create()
					@picture.update_column(:order, picture[:order])
					@picture.update_column(:public_id, picture[:public_id])
					@picture.update_column(:url, picture[:url])
				end
				format.json { render json: {}, status: :created }
			end
		end

		private

		def set_expense
			@expense = Expense.find(params[:id])
		end

		def pictures_params
      permitted_params = params.require(:pictures)
      permitted_params
    end

		def expense_params
      permitted_params = params.require(:expense).permit(
        :responsable,
        :expense_date,
        :total_ht,
        :total_ttc,
				:comment,
				:state,
				:offer_id,
        cloud_expense_pictures: [
          :expense_id,
          :order,
          :public_id,
          :url
        ]
      )

      # Expense Cloud Picture
      if permitted_params[:cloud_expense_pictures]
          cloud_expense_pictures = @expense.nil? || @expense.cloud_expense_pictures.nil? ? CloudExpensePicture.new : @expense.cloud_expense_pictures
          cloud_expense_pictures.build(permitted_params[:cloud_expense_pictures])
          permitted_params[:cloud_expense_pictures] = cloud_expense_pictures
      end

      permitted_params
    end


end
