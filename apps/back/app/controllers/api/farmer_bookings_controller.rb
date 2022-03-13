class Api::FarmerBookingsController < ApiController
  protect_from_forgery prepend: true

  before_action :set_farmer, only: [:index, :show, :edit, :update, :create]
  before_action :set_booking, only: [:show, :edit, :update, :add_pictures, :destroy]

  # GET /bookings
  # GET /bookings.json
  def index
    
    @farmer.update(payments_authorisation: set_stripe_valid(@farmer))

    @bookings = Booking.joins(offer: :farmer).where("offers.farmer_id = #{params[:farmer_id]}").order(created_at: :desc)

    if params[:status]
      @bookings = @bookings.where(status: params[:status]).order(created_at: :desc)
    end

    respond_to do |format|
      format.json { render template: 'bookings/index', status: :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_farmer
      @farmer = Farmer.find(params[:farmer_id])
    end

    def set_booking
      @booking = Booking.find(params[:booking_id])
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def booking_params
      permitted_params = params.require(:booking).permit(
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
        offer_settlement = @offer.nil? || @offer.offer_settlement.nil? ? bookingsettlement.new : @offer.offer_settlement
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

      # Offer Agriculture Type
      if permitted_params[:offer_agriculture_type]
        offer_agriculture_type = @offer.nil? || @offer.offer_agriculture_type.nil? ? OfferAgricultureType.new : @offer.offer_agriculture_type
        offer_agriculture_type.assign_attributes(permitted_params[:offer_agriculture_type])
        permitted_params[:offer_agriculture_type] = offer_agriculture_type
      end

      permitted_params
    end
end
