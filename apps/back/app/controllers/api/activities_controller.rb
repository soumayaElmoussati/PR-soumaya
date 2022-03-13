class Api::ActivitiesController < ApiController

  protect_from_forgery prepend: true

  before_action :set_farmer, only: [:show, :edit, :update, :create]
  before_action :set_activity, only: [:show, :edit, :update, :add_pictures, :destroy]

  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.all
      .published
      .page(params[:page]).per(30)

    @count = @activities.count

    respond_to do |format|
      format.json { render template: 'activities/index', status: :ok }
    end
  end

  def bretagne

    @activities = Activity.joins(:farmer).published.where("agriculteur_de_bretagne = ?", true)
      .page(params[:page]).per(30)

    @count = @activities.count

    respond_to do |format|
      format.json { render template: 'activities/bretagne', status: :ok }
    end
  end

  def show
    respond_to do |format|
      format.json { render template: 'activities/show', status: :ok }
    end
  end

  # GET /activities/new
  def new
    @activity = Activity.new
    format.json { render json: @activity, status: :ok }
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(activity_params)

    respond_to do |format|
      if @activity.save!
        format.json { render template: 'activities/show', status: :created }
      else
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /activities/1/edit
  def edit
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.json { render template: 'activities/show', status: :ok }
      else
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url, notice: 'Activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /add_pictures
  # POST /add_pictures.json
  def add_pictures
    respond_to do |format|
      if pictures_params.count > 0
        pictures_params.each do |picture|
          @picture = @activity.pictures.create()
          @picture.update_column(:image, "image/upload/#{picture[:public_id]}")
        end

        @activity = Activity.find(params[:id])
        format.json { render template: 'activities/show', status: :created }
      else
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /replace_pictures
  # POST /replace_pictures.json
  def replace_pictures
    respond_to do |format|
      @activity = Activity.find(params[:id])
      @activity.cloud_activity_pictures = []
      pictures_params.each do |picture|
        @picture = @activity.cloud_activity_pictures.create()
        @picture.update_column(:order, picture[:order])
        @picture.update_column(:public_id, picture[:public_id])
        @picture.update_column(:url, picture[:url])
      end
      format.json { render json: {}, status: :created }
    end
  end

  def remove_picture
    respond_to do |format|
      puts "pictures removal", pictures_params
      @activity = Activity.find(params[:id])
      @picture = @activity.pictures.find(params[:picture_id])
      @picture.destroy
      format.html { redirect_to activities_url, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # def forced_activity
  #   @result = JSON.parse(File.read('public/api/activities.json'))

  #   respond_to do |format|
  #     format.json { render json: @result, status: :ok }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_farmer
      @farmer = Farmer.where(user: current_user).first
    end

    def set_activity
      @activity = Activity.find(params[:id])
    end

    def pictures_params
      permitted_params = params.require(:pictures)
      permitted_params
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      permitted_params = params.require(:activity).permit(
        :farmer_id,
        :name,
        :slug,
        :people_count,
        :price_per_person,
        :additional_max_people,
        :additional_traveler_price,
        :departure_time,
        :departure_min_time,
        :arriving_time,
        :arriving_min_time,
        :max_people_count,
        cloud_activity_pictures: [
          :activity_id,
          :count,
          :public_id,
          :url
        ],
        activity_address: [
          :name,
          :street_name,
          :city,
          :state,
          :postal_code,
          :area_code,
          :country_code,
          :lat,
          :lng
        ],
        activity_farm_type: [
          :breeder,
          :cereal,
          :horticulturist,
          :market_gardener,
          :cheese_production,
          :winegrower,
          :brewer,
          :arborist,
          :oyster_farmer,
          :mushroom_grower,
          :beekeeper,
          :cider_maker,
          :riding_stable,
          :agroforestry
        ],
        activity_agriculture_type: [
          :biological,
          :permaculture,
          :agroecology,
          :agroecological,
          :conventional,
          :ringing,
          :durable,
          :reliability,
          :hydroponics
        ],
        activity_tag: [
          :playful,
          :pedagogic,
          :unusual,
          :public,
          :gustatory,
          :animal,
          :dirty,
          :rewarding,
          :depth,
          :intensive,
          :quick,
          :physical
        ],
        activity_animal: [
          :cow,
          :milk_cow,
          :sheep,
          :goat,
          :pig,
          :rabbit,
          :duck,
          :goose,
          :turkey,
          :chicken,
          :donkey,
          :snail,
          :horse,
          :bee,
          :lama
        ],
        activity_settlement: [
          :baby_suitable,
          :child_suitable,
          :smooking_allowed,
          :parties_allowed,
          :animals_welcome,
          :accessible,
          :additional_rules
        ],
        activity_description: [
          :residence,
          :farmer,
          :activities,
          :farm,
          :discovery,
          :meeting_animals,
          :milking_animals,
          :tasting,
          :birth_animal,
          :stroll,
          :harvest,
          :craft
        ]
      )

      # NOTE: Address
      if permitted_params[:activity_address]
        activity_address = @activity.nil? || @activity.activity_address.nil? ? ActivityAddress.new : @activity.activity_address
        activity_address.assign_attributes(permitted_params[:activity_address])
        permitted_params[:activity_address] = activity_address
      end

      # NOTE: Activity farm type
      if permitted_params[:activity_farm_type]
        activity_farm_type = @activity.nil? || @activity.activity_farm_type.nil? ? ActivityFarmType.new : @activity.activity_farm_type
        activity_farm_type.assign_attributes(permitted_params[:activity_farm_type])
        permitted_params[:activity_farm_type] = activity_farm_type
      end

      # NOTE: Activity agriculture type
      if permitted_params[:activity_agriculture_type]
        activity_agriculture_type = @activity.nil? || @activity.activity_agriculture_type.nil? ? ActivityAgricultureType.new : @activity.activity_agriculture_type
        activity_agriculture_type.assign_attributes(permitted_params[:activity_agriculture_type])
        permitted_params[:activity_agriculture_type] = activity_agriculture_type
      end

      # NOTE: Activity Cloud Picture
      if permitted_params[:cloud_activity_pictures]
          cloud_activity_pictures = @activity.nil? || @activity.cloud_activity_pictures.nil? ? CloudActivityPicture.new : @activity.cloud_activity_pictures
          cloud_activity_pictures.build(permitted_params[:cloud_activity_pictures])
          permitted_params[:cloud_activity_pictures] = cloud_activity_pictures
      end

      # NOTE: Activity Tag
      if permitted_params[:activity_tag]
        activity_tag = @activity.nil? || @activity.activity_tag.nil? ? ActivityTag.new : @activity.activity_tag
        activity_tag.assign_attributes(permitted_params[:activity_tag])
        permitted_params[:activity_tag] = activity_tag
      end

      # NOTE: Activity animal
      if permitted_params[:activity_animal]
        activity_animal = @activity.nil? || @activity.activity_animal.nil? ? ActivityAnimal.new : @activity.activity_animal
        activity_animal.assign_attributes(permitted_params[:activity_animal])
        permitted_params[:activity_animal] = activity_animal
      end

      # NOTE: Activity settlement
      if permitted_params[:activity_settlement]
        activity_settlement = @activity.nil? || @activity.activity_settlement.nil? ? ActivitySettlement.new : @activity.activity_settlement
        activity_settlement.assign_attributes(permitted_params[:activity_settlement])
        permitted_params[:activity_settlement] = activity_settlement
      end

      # NOTE: Activity description
      if permitted_params[:activity_description]
        activity_description = @activity.nil? || @activity.activity_description.nil? ? ActivityDescription.new : @activity.activity_description
        activity_description.assign_attributes(permitted_params[:activity_description])
        permitted_params[:activity_description] = activity_description
      end

      permitted_params
    end

end
