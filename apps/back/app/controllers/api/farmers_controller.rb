class Api::FarmersController < ApiController
  protect_from_forgery prepend: true

  before_action :set_farmer, only: [:show, :edit, :update, :add_pictures]

  def edit
  end

  def update
    respond_to do |format|
      if @farmer.update!(farmer_params)
        format.json { render template: 'farmers/show', status: :ok }
      else
        format.json { render json: @farmer.errors, status: :unprocessable_entity }
      end
    end
  end

  def show

    @farmer.stripe_link = set_stripe_url(@farmer)
    @farmer.payments_authorisation = set_stripe_valid(@farmer)
    @farmer.save
    respond_to do |format|
      format.json { render template: 'farmers/show', status: :ok }
    end
  end

  # POST /add_pictures
  # POST /add_pictures.json
  def add_pictures
    respond_to do |format|
      puts "pictures", pictures_params
      if pictures_params.count > 0
        pictures_params.each do |picture|
          @picture = @farmer.pictures.create()
          @picture.update_column(:image, "image/upload/#{picture[:public_id]}")
        end

        @farmer = Farmer.find(params[:id])
        format.json { render template: 'farmers/show', status: :created }
      else
        format.json { render json: @farmer.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove_picture
    respond_to do |format|
      puts "pictures removal", pictures_params
      @farmer = Farmer.find(params[:id])
      @picture = @farmer.pictures.find(params[:picture_id])
      @picture.destroy
      format.html { redirect_to offers_url, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /replace_pictures
  # POST /replace_pictures.json
  def replace_pictures
    respond_to do |format|
      @farmer = Farmer.find(params[:id])
      @farmer.cloud_profile_pictures = []
      pictures_params.each do |picture|
        @picture = @farmer.cloud_profile_pictures.create()
        @picture.update_column(:order, picture[:order])
        @picture.update_column(:public_id, picture[:public_id])
        @picture.update_column(:url, picture[:url])
      end
      format.json { render json: {}, status: :created }
    end
  end



  private

    def set_farmer
      @farmer = Farmer.find(params[:id])
    end

    def set_stripe_url(farmer)

      if Rails.env != "production"
        api_key = 'sk_test_Rn5msomXPxHV2Y5ynnVopH3t'
      else
        api_key = 'sk_live_5yu6ZXc5hWG25fp2PXCJ7eDu004rx8VS3Q'
      end

      Stripe.api_key = api_key

      if Rails.env == "development"
        return_url = 'http://localhost:8080/farmer/' + farmer.id.to_s
        refresh_url = 'http://localhost:8080/edit-farmer/' + farmer.id.to_s + '/profile'
      elsif Rails.env == "staging"
        return_url = 'https://www.staging.agrivillage.fr/farmer/' + + farmer.id.to_s
        refresh_url = 'https://www.staging.agrivillage.fr/edit-farmer/' + farmer.id.to_s + '/profile'
      elsif Rails.env == "production"
        return_url = 'https://www.agrivillage.fr/farmer/' + farmer.id.to_s
        refresh_url = 'https://www.agrivillage.fr/edit-farmer/' + farmer.id.to_s + '/profile'
      end

      if farmer.stripe_user_id.blank?

        account = Stripe::Account.create({
          type: 'express',
          country: 'FR',
          email: farmer.user.email,
          capabilities: {
            transfers: {requested: true}
          }
        })

        farmer.stripe_user_id = account.id
        farmer.save

        account_links = Stripe::AccountLink.create({
          account: farmer.stripe_user_id,
          refresh_url: refresh_url,
          return_url: return_url,
          type: 'account_onboarding',
        })

      else

        account_links = Stripe::AccountLink.create({
          account: farmer.stripe_user_id,
          refresh_url: refresh_url,
          return_url: return_url,
          type: 'account_onboarding',
        })

      end

      return account_links.url
    end

    def set_stripe_valid(farmer)

      if Rails.env != "production"
        api_key = 'sk_test_Rn5msomXPxHV2Y5ynnVopH3t'
      else
        api_key = 'sk_live_5yu6ZXc5hWG25fp2PXCJ7eDu004rx8VS3Q'
      end

      Stripe.api_key = api_key

      if farmer.stripe_user_id != nil

        account = Stripe::Account.retrieve(farmer.stripe_user_id)

        if account.capabilities.platform_payments == "active"
          return true
        else
          return false
        end

      end

    end

    def pictures_params
      permitted_params = params.require(:pictures)
      permitted_params
    end

    # TODO: Remove user_params ?
    def user_params
      permitted_params = params.require(:user).permit(
        :first_name,
        :last_name,
        :ambassador,
        :email,
        :cellphone,
        :phone,
        :password,
        :password_confirmation,
        :birthdate
      )
      permitted_params
    end

    def farmer_params
      permitted_params = params.require(:farmer).permit(
        :description,
        :agriculteur_de_bretagne,
        :stripe_link,
        :payments_authorisation,
        cloud_profile_pictures: [
          :farmer_id,
          :count,
          :public_id,
          :url
        ],
        farmer_equipment: [
          :english,
          :spanish,
          :german,
          :italian,
          :portuguese,
          :russian,
          :dutch
        ],
        farmer_organisation: [
          :fairefrance,
          :bbc,
          :adb
        ]
      )

      # Farmer equipment
      if permitted_params[:farmer_equipment]
        farmer_equipment = @farmer.nil? || @farmer.farmer_equipment.nil? ? FarmerEquipment.new : @farmer.farmer_equipment
        farmer_equipment.assign_attributes(permitted_params[:farmer_equipment])
        permitted_params[:farmer_equipment] = farmer_equipment
      end

      # Farmer organisation
      if permitted_params[:farmer_organisation]
        farmer_organisation = @farmer.nil? || @farmer.farmer_organisation.nil? ? FarmerOrganisation.new : @farmer.farmer_organisation
        farmer_organisation.assign_attributes(permitted_params[:farmer_organisation])
        permitted_params[:farmer_organisation] = farmer_organisation
      end

      # Farmer Cloud Picture
      if permitted_params[:cloud_profile_pictures]
          cloud_profile_pictures = @farmer.nil? || @farmer.cloud_profile_pictures.nil? ? CloudProfilePicture.new : @farmer.cloud_profile_pictures
          cloud_profile_pictures.build(permitted_params[:cloud_profile_pictures])
          permitted_params[:cloud_profile_pictures] = cloud_profile_pictures
      end

      permitted_params
    end
end