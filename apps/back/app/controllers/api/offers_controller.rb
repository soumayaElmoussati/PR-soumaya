class Api::OffersController < ApiController
  protect_from_forgery prepend: true

  before_action :set_farmer, only: [:show, :edit, :update, :create]
  before_action :set_offer, only: [:show, :edit, :update, :add_pictures, :add_offer_pictures, :destroy]

  impressionist :actions=>[:show]

  def sitemap
    @offers = Offer.all.published

    respond_to do |format|
      format.json { render template: 'offers/sitemap', status: :ok }
    end

  end

  # GET /offers
  # GET /offers.json
  def index
    @offers = Offer.all
      .order(certificated: :desc)
      .published
      .page(params[:page])

    @count = @offers.count
    respond_to do |format|
      format.json { render template: 'offers/index', status: :ok }
    end
  end

  # GET /offers/search
  def search

    if params[:location]
      location = params[:location]
      distance = 50 # Distance are in kms
    else
      location = 'Paris'
      distance = 1000000
    end

    peopleCount = params[:people_count].to_i || 1

    if params[:activity]

      activity = params[:activity].gsub(/'/, '')
      activities = activity.split("||")
      activities.delete_if { |i| i == "undefined"}
      activity_query = activities.each_with_object([]) do |activity, query|
        query << "offer_descriptions.#{activity} = true"
      end.join(" OR ")

      if activities.empty?

        @offers = Offer.joins(:address)
          .published
          .where("max_people_count >= ?", peopleCount)
          .near(location, distance, unit: :km)
          .order(certificated: :desc)
          .page(params[:page])
          .per(20)

        @count = Offer.joins(:address)
          .published
          .where("max_people_count >= ?", peopleCount)
          .near(location, distance, unit: :km)
          .order(certificated: :desc)
          .count(:all)

      else

        @offers = Offer.joins(:address, :offer_description)
          .published
          .where("max_people_count >= ? AND " + activity_query, peopleCount)
          .near(location, distance, unit: :km)
          .order(certificated: :desc)
          .page(params[:page])
          .per(20)

        @count = Offer.joins(:address, :offer_description)
          .published
          .where("max_people_count >= ? AND " + activity_query, peopleCount)
          .near(location, distance, unit: :km)
          .order(certificated: :desc)
          .count(:all)

      end

      if @count == 0

        distance = 60

        if activities.empty?

          @offers = Offer.joins(:address)
            .published
            .where("max_people_count >= ?", peopleCount)
            .near(location, distance, unit: :km)
            .order(certificated: :desc)
            .page(params[:page])
            .per(20)

          @count = Offer.joins(:address)
            .published
            .where("max_people_count >= ?", peopleCount)
            .near(location, distance, unit: :km)
            .order(certificated: :desc)
            .count(:all)

        else

          @offers = Offer.joins(:address, :offer_description)
            .published
            .where("max_people_count >= ? AND " + activity_query, peopleCount)
            .near(location, distance, unit: :km)
            .order(certificated: :desc)
            .page(params[:page])
            .per(20)

          @count = Offer.joins(:address, :offer_description)
            .published
            .where("max_people_count >= ? AND " + activity_query, peopleCount)
            .near(location, distance, unit: :km)
            .order(certificated: :desc)
            .count(:all)

        end

      end

    # OTHER PARAMS NOT IN SEARCHBAR
    elsif params[:farm_type]
      farm_type = params[:farm_type].gsub(/'/, '')
      @offers = Offer.joins(:offer_farm_type).published.where("offer_farm_types.#{farm_type}=?", true).order(certificated: :desc).page(params[:page]).per(20)
    elsif params[:agriculture_type]
      agriculture_type = params[:agriculture_type].gsub(/'/, '')
      @offers = Offer.joins(:offer_agriculture_type).published.where("offer_agriculture_types.#{agriculture_type}=?", true).order(certificated: :desc).page(params[:page]).per(20)
    elsif params[:residence_type]
      residence_type = params[:residence_type].gsub(/'/, '')
      @offers = Offer.published.where("residence_type = #{residence_type}").order(certificated: :desc).page(params[:page]).per(20)
    elsif params[:animal]
      animal = params[:animal].gsub(/'/, '')
      @offers = Offer.joins(:offer_animal).published.where("offer_animals.#{animal}=?", true).order(certificated: :desc).page(params[:page]).per(20)
    else
      @offers = Offer
        .joins(:address)
        .published
        .where('max_people_count >= ?', peopleCount)
        .near(location, distance, unit: :km)
        .page(params[:page])
        .order(certificated: :desc)
        .per(20)

      @count = Offer
        .joins(:address)
        .published
        .where('max_people_count >= ?', peopleCount)
        .near(location, distance, unit: :km)
        .order(certificated: :desc)
        .count(:all)

      if @count == 0

        distance = 60

        @offers = Offer
          .joins(:address)
          .published
          .where('max_people_count >= ?', peopleCount)
          .near(location, distance, unit: :km)
          .page(params[:page])
          .order(certificated: :desc)
          .per(20)

        @count = Offer
          .joins(:address)
          .published
          .where('max_people_count >= ?', peopleCount)
          .near(location, distance, unit: :km)
          .order(certificated: :desc)
          .count(:all)

      end
    end

    if params[:date_arrive] && params[:date_depart]

      from = Date.parse(params[:date_arrive])
      to = Date.parse(params[:date_depart])

      unvailables = []

      if @count == 0
        @offers = Offer.published
      end


      @offers.each do |offer|
        if !offer.available?(from, to)
         unvailables.push(offer.id)
        end
      end

      @offers = @offers
        .where.not(id: unvailables)
        .page(params[:page])

      @count = @offers.length
    end

    respond_to do |format|
      format.json { render template: 'offers/search', status: :ok }
    end

  end

  # def forced_activity
  #   @result = JSON.parse(File.read('public/api/activities.json'))

  #   respond_to do |format|
  #     format.json { render json: @result, status: :ok }
  #   end
  # end

  # TODO: Remove as it's not used
  def bretagne
    departements = '22||29||35||56'
    area = departements.gsub(/'/, '').split('||')
    @offers = Offer.joins(:address).published.where("addresses.area_code IN (?)", area).page(params[:page]).per(20)
      .order(certificated: :desc)
    @count = Offer.joins(:address).published.where("addresses.area_code IN (?)", area).count(:all)
    @all_offers = Offer.joins(:address).published.where("addresses.area_code IN (?)", area).order(certificated: :desc)

    respond_to do |format|
      format.json { render template: 'offers/bretagne', status: :ok }
    end
  end

  # TODO: Remove as it's not used
  def aquitaine
    departements = '16||17||19||23||24||33||40||47||64||79||86||87'
    area = departements.gsub(/'/, '').split('||')
    @offers = Offer.joins(:address).published.where("addresses.area_code IN (?)", area).page(params[:page]).per(20)
      .order(certificated: :desc)
    @count = Offer.joins(:address).published.where("addresses.area_code IN (?)", area).count(:all)
    @all_offers = Offer.joins(:address).published.where("addresses.area_code IN (?)", area).order(certificated: :desc)

    respond_to do |format|
      format.json { render template: 'offers/aquitaine', status: :ok }
    end
  end

  # TODO: Remove as it's not used
  def normandie
    departements = '14||27||50||61||76'
    area = departements.gsub(/'/, '').split('||')
    @offers = Offer.joins(:address).published.where("addresses.area_code IN (?)", area).page(params[:page]).per(20)
      .order(certificated: :desc)
    @count = Offer.joins(:address).published.where("addresses.area_code IN (?)", area).count(:all)
    @all_offers = Offer.joins(:address).published.where("addresses.area_code IN (?)", area).order(certificated: :desc)

    respond_to do |format|
      format.json { render template: 'offers/normandie', status: :ok }
    end
  end

  # TODO: Remove as it's not used
  def insolit
    residence_type = '3'
    @offers = Offer.published.where("residence_type = #{residence_type}").order(certificated: :desc).page(params[:page]).per(20).limit(3)
    @count = Offer.published.where("residence_type = #{residence_type}").limit(3).count(:all)
    @all_offers = Offer.published.where("residence_type = #{residence_type}").order(certificated: :desc).limit(3)

    respond_to do |format|
      format.json { render template: 'offers/insolit', status: :ok }
    end

  end

  # TODO: Remove as it's not used
  def host
    residence_type = '2'
    @offers = Offer.published.where("residence_type = #{residence_type}").order(certificated: :desc).page(params[:page]).per(20).limit(3)
    @count = Offer.published.where("residence_type = #{residence_type}").limit(3).count(:all)
    @all_offers = Offer.published.where("residence_type = #{residence_type}").order(certificated: :desc).limit(3)

    respond_to do |format|
      format.json { render template: 'offers/host', status: :ok }
    end

  end

  # TODO: Remove as it's not used
  def lodge
    residence_type = '0'
    @offers = Offer.published.where("residence_type = #{residence_type}").order(certificated: :desc).page(params[:page]).per(20).limit(3)
    @count = Offer.published.where("residence_type = #{residence_type}").limit(3).count(:all)
    @all_offers = Offer.published.where("residence_type = #{residence_type}").order(certificated: :desc).limit(3)

    respond_to do |format|
      format.json { render template: 'offers/lodge', status: :ok }
    end
  end

  def tiny
    residence_type = '4'

    @offers = Offer.published.where("residence_type = #{residence_type}").order(certificated: :desc).page(params[:page]).per(20)
    @count = Offer.published.where("residence_type = #{residence_type}").count(:all)
    @all_offers = Offer.published.where("residence_type = #{residence_type}").order(certificated: :desc)
   
    respond_to do |format|
      format.json { render template: 'offers/tiny', status: :ok }
    end
  end

  def familly

    @offers = Offer.published.order(certificated: :desc).page(params[:page]).per(20).limit(3)
    @count = Offer.published.limit(3).count(:all)
    @all_offers = Offer.published.order(certificated: :desc).limit(3)
   
    respond_to do |format|
      format.json { render template: 'offers/host', status: :ok }
    end
  end

  # CRUD

  # GET /offers/new
  def new
    @offer = Offer.new
    format.json { render json: @offer, status: :ok }
  end

  # POST /offers
  # POST /offers.json
  def create
    @offer = Offer.new(offer_params)

    respond_to do |format|
      if @offer.save!
        format.json { render template: 'offers/show', status: :created }
      else
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /offers/1/edit
  def edit
  end

  # PATCH/PUT /offers/1
  # PATCH/PUT /offers/1.json
  def update
    respond_to do |format|
      if @offer.update(offer_params)
        UpdateOfferJob.perform_later(@offer)
        format.json { render template: 'offers/show', status: :ok }
      else
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /offers/1
  # GET /offers/1.json
  def show
    impressionist(@offer)
    @promocodes = Promocode.all
    @bookings = @offer.bookings.to_display
    @external_bookings = @offer.external_bookings
    array = []
    @bookings.each do |booking|
      array << booking.id
    end
    @reviews = Review.joins(:booking).where('booking_id IN (?) AND state = 2', array).sample(3)
    respond_to do |format|
      format.json { render template: 'offers/show', status: :ok }
    end
  end

  # DELETE /offers/1
  # DELETE /offers/1.json
  def destroy
    @offer.destroy
    respond_to do |format|
      format.html { redirect_to offers_url, notice: 'Offer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /add_pictures
  # POST /add_pictures.json
  def add_pictures
    respond_to do |format|
      if pictures_params.count > 0
        pictures_params.each do |picture|
          @picture = @offer.pictures.create()
          @picture.update_column(:image, "image/upload/#{picture[:public_id]}")
        end

        @offer = Offer.find(params[:id])
        format.json { render template: 'offers/show', status: :created }
      else
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /remove_picture
  # POST /remove_picture.json
  def remove_picture
    respond_to do |format|
      @offer = Offer.find(params[:id])
      @picture = @offer.pictures.find(params[:picture_id])
      @picture.destroy
      format.html { redirect_to offers_url, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /replace_pictures
  # POST /replace_pictures.json
  def replace_pictures
    respond_to do |format|
      @offer = Offer.find(params[:id])
      @offer.cloud_pictures = []
      pictures_params.each do |picture|
        @picture = @offer.cloud_pictures.create()
        @picture.update_column(:order, picture[:order])
        @picture.update_column(:public_id, picture[:public_id])
        @picture.update_column(:url, picture[:url])
        @picture.update_column(:picture_type, picture[:picture_type])
      end
      format.json { render json: {}, status: :created }
    end
  end

  # POST /replace_offer_pictures
  # POST /replace_offer_pictures.json
  def replace_offer_pictures
    respond_to do |format|
      @offer = Offer.find(params[:id])
      @offer.cloud_offer_pictures = []
      pictures_params.each do |picture|
        @picture = @offer.cloud_offer_pictures.create()
        @picture.update_column(:order, picture[:order])
        @picture.update_column(:public_id, picture[:public_id])
        @picture.update_column(:url, picture[:url])
      end
      format.json { render json: {}, status: :created }
    end
  end

  private

    def set_farmer
      @farmer = Farmer.where(user: current_user).first
    end

    def set_offer
      @offer = Offer.find(params[:id])
    end

    def pictures_params
      permitted_params = params.require(:pictures)
      permitted_params
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offer_params
      permitted_params = params.require(:offer).permit(
        :farmer_id,
        :name,
        :certificated,
        :manager,
        :instant_booking,
        :slug,
        :departure_time,
        :departure_min_time,
        :arriving_time,
        :arriving_min_time,
        :people_count,
        :residence_type,
        :price_per_person,
        :additional_max_people,
        :min_days,
        :additional_traveler_price,
        :deposit,
        :tourist_tax,
        :annexe_information,
        :max_people_count,
        :toilets_count,
        :sleeps_count,
        :bathrooms_count,
        :rooms_count,
        :impressions_count,
        :icalendar_url,
        icalendar_urls: [],
        address: [
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
        offer_description: [
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
        ],
        offer_benefit: [
          :cleaning_kit,
          :toilet_paper,
          :soap,
          :household_linen
        ],
        offer_equipment: [
          :kitchen,
          :wifi,
          :tv,
          :washing_machine,
          :fireplace,
          :parking,
          :swimming_pool,
          :domestic_animals,
          :english_speaking,
          :private_garden,
          :shared_garden,
          :internet,
          :dvd_player,
          :games,
          :dryer,
          :hair_dryer,
          :drying_rack,
          :iron,
          :wardrobe,
          :shower,
          :bath,
          :baby_bath,
          :heater,
          :clim,
          :fitness,
          :garden_lounge,
          :bbq,
          :oven,
          :hotplates,
          :microwaves,
          :toaster,
          :kettle,
          :coffee_machine,
          :cutlery,
          :dishwasher,
          :baby_chair,
          :fridge,
          :deep_freezer,
          :freezer,
          :garage,
          :secure_local,
          :train
        ],
        offer_settlement: [
          :baby_suitable,
          :child_suitable,
          :smooking_allowed,
          :parties_allowed,
          :animals_welcome,
          :accessible,
          :additional_rules
        ],
        annexe_services: [
          :name,
          :description,
          :price,
          :unity
        ],
        expenses: [
          :responsable,
          :expense_date,
          :total_ht,
          :total_ttc,
          :comment
        ],
        offer_animal: [
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
        offer_price_discounts: [
          :offer_id,
          :percentage_discount,
          :min_nights
        ],
        cloud_pictures: [
          :offer_id,
          :count,
          :public_id,
          :picture_type,
          :url
        ],
        cloud_offer_pictures: [
          :offer_id,
          :count,
          :public_id,
          :url
        ],
        offer_service: [
          :breakfast,
          :breakfast_price,
          :linens,
          :linens_price,
          :host_table,
          :host_table_price,
          :esprit_ferme,
          :esprit_link,
          :cleaning,
          :cleaning_price,
          :breakfastopt,
          :linensopt,
          :cleaningopt
        ],
        offer_price_weekend: [
          :price,
          :both_days
        ],
        offer_agriculture_type: [
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
        offer_adjectif: [
          :rustic,
          :luxurious,
          :confortable,
          :clean,
          :friendly,
          :calm,
          :exotic,
          :romantic,
          :cheap,
          :insolit,
          :simple,
          :luminous
        ],
        offer_tag: [
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
        offer_farm_type: [
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
        ]
      )

      # NOTE: Address
      if permitted_params[:address]
        address = @offer.nil? || @offer.address.nil? ? Address.new : @offer.address
        address.assign_attributes(permitted_params[:address])
        permitted_params[:address] = address
      end

      # NOTE: Offer description
      if permitted_params[:offer_description]
        offer_description = @offer.nil? || @offer.offer_description.nil? ? OfferDescription.new : @offer.offer_description
        offer_description.assign_attributes(permitted_params[:offer_description])
        permitted_params[:offer_description] = offer_description
      end

      # NOTE: Offer equipment
      if permitted_params[:offer_equipment]
        offer_equipment = @offer.nil? || @offer.offer_equipment.nil? ? OfferEquipment.new : @offer.offer_equipment
        offer_equipment.assign_attributes(permitted_params[:offer_equipment])
        permitted_params[:offer_equipment] = offer_equipment
      end

      # NOTE: Offer benefit
      if permitted_params[:offer_benefit]
        offer_benefit = @offer.nil? || @offer.offer_benefit.nil? ? OfferBenefit.new : @offer.offer_benefit
        offer_benefit.assign_attributes(permitted_params[:offer_benefit])
        permitted_params[:offer_benefit] = offer_benefit
      end

      # NOTE: Offer settlement
      if permitted_params[:offer_settlement]
        offer_settlement = @offer.nil? || @offer.offer_settlement.nil? ? OfferSettlement.new : @offer.offer_settlement
        offer_settlement.assign_attributes(permitted_params[:offer_settlement])
        permitted_params[:offer_settlement] = offer_settlement
      end

      # NOTE: Offer price weekend
      if permitted_params[:offer_price_weekend]
        offer_price_weekend = @offer.nil? || @offer.offer_price_weekend.nil? ? OfferPriceWeekend.new : @offer.offer_price_weekend
        offer_price_weekend.assign_attributes(permitted_params[:offer_price_weekend])
        permitted_params[:offer_price_weekend] = offer_price_weekend
      end

      # NOTE: Offer animal
      if permitted_params[:offer_animal]
        offer_animal = @offer.nil? || @offer.offer_animal.nil? ? OfferAnimal.new : @offer.offer_animal
        offer_animal.assign_attributes(permitted_params[:offer_animal])
        permitted_params[:offer_animal] = offer_animal
      end

      # NOTE: Offer Price discount
      if permitted_params[:offer_price_discounts]
          offer_price_discount = @offer.nil? || @offer.offer_price_discounts.nil? ? OfferPriceDiscount.new : @offer.offer_price_discounts
          offer_price_discount.build(permitted_params[:offer_price_discounts])
          permitted_params[:offer_price_discounts] = offer_price_discount
      end

      # NOTE: Offer Annexe services
      if permitted_params[:annexe_services]
          annexe_service = @offer.nil? || @offer.annexe_services.nil? ? AnnexeService.new : @offer.annexe_services
          annexe_service.build(permitted_params[:annexe_services])
          permitted_params[:annexe_services] = annexe_service
      end

      # NOTE: Offer Cloud Picture
      if permitted_params[:cloud_pictures]
          cloud_pictures = @offer.nil? || @offer.cloud_pictures.nil? ? CloudPicture.new : @offer.cloud_pictures
          cloud_pictures.build(permitted_params[:cloud_pictures])
          permitted_params[:cloud_pictures] = cloud_pictures
      end

      # NOTE: Offer Cloud Picture
      if permitted_params[:cloud_offer_pictures]
          cloud_offer_pictures = @offer.nil? || @offer.cloud_offer_pictures.nil? ? CloudOfferPicture.new : @offer.cloud_offer_pictures
          cloud_offer_pictures.build(permitted_params[:cloud_offer_pictures])
          permitted_params[:cloud_offer_pictures] = cloud_offer_pictures
      end

      # NOTE: Offer service
      if permitted_params[:offer_service]
        offer_service = @offer.nil? || @offer.offer_service.nil? ? OfferService.new : @offer.offer_service
        offer_service.assign_attributes(permitted_params[:offer_service])
        permitted_params[:offer_service] = offer_service
      end

      # NOTE: Offer farm type
      if permitted_params[:offer_farm_type]
        offer_farm_type = @offer.nil? || @offer.offer_farm_type.nil? ? OfferFarmType.new : @offer.offer_farm_type
        offer_farm_type.assign_attributes(permitted_params[:offer_farm_type])
        permitted_params[:offer_farm_type] = offer_farm_type
      end

      # NOTE: Offer agriculture type
      if permitted_params[:offer_agriculture_type]
        offer_agriculture_type = @offer.nil? || @offer.offer_agriculture_type.nil? ? OfferAgricultureType.new : @offer.offer_agriculture_type
        offer_agriculture_type.assign_attributes(permitted_params[:offer_agriculture_type])
        permitted_params[:offer_agriculture_type] = offer_agriculture_type
      end

      # NOTE: Offer adjectif
      if permitted_params[:offer_adjectif]
        offer_adjectif = @offer.nil? || @offer.offer_adjectif.nil? ? OfferAdjectif.new : @offer.offer_adjectif
        offer_adjectif.assign_attributes(permitted_params[:offer_adjectif])
        permitted_params[:offer_adjectif] = offer_adjectif
      end

      # NOTE: Offer Tag
      if permitted_params[:offer_tag]
        offer_tag = @offer.nil? || @offer.offer_tag.nil? ? OfferTag.new : @offer.offer_tag
        offer_tag.assign_attributes(permitted_params[:offer_tag])
        permitted_params[:offer_tag] = offer_tag
      end

      # NOTE: Offer Icalendar
      if permitted_params[:icalendar_url]
        permitted_params[:icalendar_urls] = @offer.icalendar_urls + [permitted_params.delete(:icalendar_url)]
      end

      permitted_params
    end
end
