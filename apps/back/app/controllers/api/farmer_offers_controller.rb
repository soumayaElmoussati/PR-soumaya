class Api::FarmerOffersController < ApiController
  protect_from_forgery prepend: true

  before_action :set_farmer, only: [:index, :show, :edit, :update, :create]
  before_action :set_offer, only: [:show, :edit, :update, :add_pictures, :destroy]

  # GET /offers
  # GET /offers.json
  def index
    @offers = @farmer.offers.page(params[:page])
    respond_to do |format|
      format.json { render template: 'offers/index', status: :ok }
    end
  end

  # # GET /offers/1
  # # GET /offers/1.json
  # def show
  #   respond_to do |format|
  #     format.json { render template: 'offers/show', status: :ok }
  #   end
  # end

  # # GET /offers/new
  # def new
  #   @offer = Offer.new
  #   format.json { render json: @offer, status: :ok }
  # end

  # # GET /offers/1/edit
  # def edit
  # end

  # # POST /offers
  # # POST /offers.json
  # def create
  #   @offer = Offer.new(offer_params)

  #   respond_to do |format|
  #     if @offer.save
  #       format.json { render template: 'offers/show', status: :created }
  #     else
  #       format.json { render json: @offer.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # POST /add_pictures
  # # POST /add_pictures.json
  # def add_pictures
  #   respond_to do |format|
  #     puts "pictures", pictures_params
  #     if pictures_params.count > 0
  #       pictures_params.each do |picture|
  #         @picture = @offer.pictures.create()
  #         @picture.update_column(:image, "image/upload/#{picture[:public_id]}")
  #       end

  #       @offer = Offer.find(params[:id])
  #       format.json { render template: 'offers/show', status: :created }
  #     else
  #       format.json { render json: @offer.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PATCH/PUT /offers/1
  # # PATCH/PUT /offers/1.json
  # def update
  #   respond_to do |format|
  #     if @offer.update(offer_params)
  #       format.json { render template: 'offers/show', status: :ok }
  #     else
  #       format.json { render json: @offer.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /offers/1
  # # DELETE /offers/1.json
  # def destroy
  #   @offer.destroy
  #   respond_to do |format|
  #     format.html { redirect_to offers_url, notice: 'Offer was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_farmer
      @farmer = Farmer.find(params[:farmer_id])
    end

    def set_offer
      @offer = Offer.find(params[:offer_id])
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
        :slug,
        :people_count,
        :residence_type,
        :price_per_person,
        :additional_max_people,
        :min_days,
        :additional_traveler_price,
        :deposit,
        address: [
          :name,
          :street_name,
          :city,
          :state,
          :postal_code,
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
        offer_equipment: [
          :breakfast,
          :kitchen,
          :base_equipments,
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
          :freezer,
          :deep_freezer,
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
        offer_animal: [
          :cow,
          :bee,
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
          :lama
        ]
      )

      # Address
      if permitted_params[:address]
        address = @offer.nil? || @offer.address.nil? ? Address.new : @offer.address
        address.assign_attributes(permitted_params[:address])
        permitted_params[:address] = address
      end

      # Offer Description
      if permitted_params[:offer_description]
        offer_description = @offer.nil? || @offer.offer_description.nil? ? OfferDescription.new : @offer.offer_description
        offer_description.assign_attributes(permitted_params[:offer_description])
        permitted_params[:offer_description] = offer_description
      end

      # Offer Equipment
      if permitted_params[:offer_equipment]
        offer_equipment = @offer.nil? || @offer.offer_equipment.nil? ? OfferEquipment.new : @offer.offer_equipment
        offer_equipment.assign_attributes(permitted_params[:offer_equipment])
        permitted_params[:offer_equipment] = offer_equipment
      end

      # Offer Settlement
      if permitted_params[:offer_settlement]
        offer_settlement = @offer.nil? || @offer.offer_settlement.nil? ? OfferSettlement.new : @offer.offer_settlement
        offer_settlement.assign_attributes(permitted_params[:offer_settlement])
        permitted_params[:offer_settlement] = offer_settlement
      end

      # Offer Animal
      if permitted_params[:offer_animal]
        offer_animal = @offer.nil? || @offer.offer_animal.nil? ? OfferAnimal.new : @offer.offer_animal
        offer_animal.assign_attributes(permitted_params[:offer_animal])
        permitted_params[:offer_animal] = offer_animal
      end

      # Offer Farm Type
      if permitted_params[:offer_farm_type]
        offer_farm_type = @offer.nil? || @offer.offer_farm_type.nil? ? OfferFarmType.new : @offer.offer_farm_type
        offer_farm_type.assign_attributes(permitted_params[:offer_farm_type])
        permitted_params[:offer_farm_type] = offer_farm_type
      end

      # Offer Agriculture Type
      if permitted_params[:offer_agriculture_type]
        offer_agriculture_type = @offer.nil? || @offer.offer_agriculture_type.nil? ? OfferAgricultureType.new : @offer.offer_agriculture_type
        offer_agriculture_type.assign_attributes(permitted_params[:offer_agriculture_type])
        permitted_params[:offer_agriculture_type] = offer_agriculture_type
      end

      # Offer Adjectif
      if permitted_params[:offer_adjectif]
        offer_adjectif = @offer.nil? || @offer.offer_adjectif.nil? ? OfferAdjectif.new : @offer.offer_adjectif
        offer_adjectif.assign_attributes(permitted_params[:offer_adjectif])
        permitted_params[:offer_adjectif] = offer_adjectif
      end

      # Offer Tag
      if permitted_params[:offer_tag]
        offer_tag = @offer.nil? || @offer.offer_tag.nil? ? OfferTag.new : @offer.offer_tag
        offer_tag.assign_attributes(permitted_params[:offer_tag])
        permitted_params[:offer_tag] = offer_tag
      end

      permitted_params
    end
end
