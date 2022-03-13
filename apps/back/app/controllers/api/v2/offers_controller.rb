class Api::V2::OffersController < ApiController
  protect_from_forgery prepend: true

  api :GET, '/offers'
  param :min_price, :number, desc: 'Minimum price per person'
  param :max_price, :number, desc: 'Maximum price per person'
  param :people_count, :number, desc: 'People count (1 by default)'
  param :distance, :number, desc: 'Distance in km (50km by default)'
  param :arrival_date, DateValidator, desc: 'Arrival date as YYYY-MM-DD'
  param :departure_date, DateValidator, desc: 'Departure date as YYYY-MM-DD'
  param :location, String, desc: 'Location'
  param :area, ListValidator, desc: 'Pre-defined area location.', values: [
    'bretagne',
    'aquitaine',
    'normandie'
  ]
  param :activities, ListValidator, desc: 'List of activities separated by a comma', values: [
    'discovery',
    'meeting_animals',
    'milking_animals',
    'tasting',
    'birth_animal',
    'stroll',
    'harvest',
    'craft'
  ]
  param :residence_type, ListValidator, desc: 'List of residence types separated by a comma', values: Offer.residence_types.keys
  param :animals, ListValidator, desc: 'List of animals', values: [
    'cow',
    'milk_cow',
    'sheep',
    'goat',
    'pig',
    'rabbit',
    'duck',
    'goose',
    'turkey',
    'chicken',
    'donkey',
    'snail',
    'horse',
    'bee',
    'lama',
  ]
  param :farm_types, ListValidator, desc: 'List of farm types separated by a comma', values: [
    'breeder',
    'cereal',
    'horticulturist',
    'market_gardener',
    'cheese_production',
    'winegrower',
    'brewer',
    'arborist',
    'oyster_farmer',
    'mushroom_grower',
    'beekeeper',
    'cider_maker',
    'riding_stable',
    'agroforestry',
  ]
  param :agriculture_types, ListValidator, desc: 'List of agriculture types separated by a comma', values: [
    'biological',
    'permaculture',
    'agroecology',
    'agroecological',
    'conventional',
    'ringing',
    'durable',
    'reliability',
    'hydroponics'
  ]
  param :equipments, ListValidator, desc: 'List of equipments separated by a comma', values: [
    'fireplace',
    'wifi',
    'swimming_pool',
    'parking',
    'bbq'
  ]
  param :settlements, ListValidator, desc: 'List of settlements separated by a comma', values: [
    'animals_welcome',
    'accessible',
    'parking',
    'bbq'
  ]
  param :services, ListValidator, desc: 'List of services separated by a comma', values: [
    'breakfast'
  ]
  def index
    if offer_params[:arrival_date].present?
      if offer_params[:arrival_date] < DateTime.now
        raise Apipie::ParamInvalid.new('arrival_date', params[:arrival_date], 'The arrival date should be in the future.')
      end

      if offer_params[:departure_date].present? && offer_params[:departure_date] < offer_params[:arrival_date]
        raise Apipie::ParamInvalid.new('departure_date', params[:departure_date], 'The departure date should be after the arrival date.')
      end
    end

    if offer_params[:departure_date].present? && offer_params[:departure_date] < DateTime.now
      raise Apipie::ParamInvalid.new('departure_date', params[:departure_date], 'The departure date should be in the future.')
    end

    distance = offer_params[:distance] || 50

    if distance < 10 || distance > 200
      raise Apipie::ParamInvalid.new('distance', distance, 'Distance must be between 10km and 200km.')
    end

    @near_ids = nil
    if params[:location].present?
      @near_ids = Offer.joins(:address)
        .near(params[:location], distance, unit: :km, order: '')
        .pluck(:id)

      if @near_ids.count === 0
        # Return the offers and skip the rest of the queries
        # since there is no offer nearby anyway.
        @offers = Offer.none
          .page(params[:page])
          .per(60)

        respond_to do |format|
          format.json { render template: 'offers/v2/search', status: :ok }
        end
        return false
      end
    end

    @offers = Offer
        .includes(
          :address,
          :offer_animal,
          :offer_agriculture_type,
          :offer_farm_type,
          :offer_equipment,
          :offer_settlement,
          :offer_description,
          :offer_service,
          :offer_promotions,
          :cloud_pictures,
          farmer: [:user, :farmer_organisation]
        ).published

    if offer_params[:arrival_date].present? && offer_params[:departure_date].present?

      available_bookings = Booking.available(offer_params[:arrival_date], offer_params[:departure_date]).to_sql

      joins = "left outer join (#{available_bookings}) as available_bookings on available_bookings.offer_id = offers.id"

      # @offers = @offers.joins(joins).
      #           select("offers.*, count(available_bookings.id)").
      #           group("offers.id").
      #           having("count(available_bookings.id) = 0")

    end

    if offer_params[:min_price].present?
      if offer_params[:min_price] < 0
        raise Apipie::ParamInvalid.new('min_price', params[:min_price], 'Must be greater than zero.')
      end

      @offers = @offers.where('price_per_person >= ?', offer_params[:min_price])
    end

    if offer_params[:max_price].present?
      if offer_params[:min_price].present? && offer_params[:max_price] < offer_params[:min_price]
        raise Apipie::ParamInvalid.new('max_price', params[:max_price], 'Must be greater than the min_price.')
      end

      @offers = @offers.where('price_per_person <= ?', offer_params[:max_price])
    end

    if offer_params[:people_count].present?
      @offers = @offers.where('max_people_count >= ?', offer_params[:people_count])
    end

    if params[:animals].present?
      animals = params[:animals].split(',').map { |v| v.strip }
      @offers = @offers.with_animals(animals)
    end

    if params[:residence_type].present?
      residence_types = params[:residence_type].split(',').map { |v| v.strip }
      @offers = @offers.where(residence_type: residence_types)
    end

    if params[:agriculture_types].present?
      agriculture_types = params[:agriculture_types].split(',').map { |v| v.strip }
      @offers = @offers.with_agriculture_types(agriculture_types)
    end

    if params[:farm_types].present?
      farm_types = params[:farm_types].split(',').map { |v| v.strip }
      @offers = @offers.with_farm_types(farm_types)
    end

    if params[:equipments].present?
      equipments = params[:equipments].split(',').map { |v| v.strip }
      @offers = @offers.with_equipments(equipments)
    end

    if params[:settlements].present?
      settlements = params[:settlements].split(',').map { |v| v.strip }
      @offers = @offers.with_settlements(settlements)
    end

    if params[:activities].present?
      activities = params[:activities].split(',').map { |v| v.strip }
      @offers = @offers.with_activities(activities)
    end

    if params[:services].present?
      services = params[:services].split(',').map { |v| v.strip }
      @offers = @offers.with_services(services)
    end

    if params[:area].present?
      areas = {
        bretagne: [22, 29, 35, 56],
        aquitaine: [16, 17, 19, 23, 24, 33, 40, 47, 64, 79, 86, 87],
        normandie: [14, 27, 50, 61, 76]
      }

      codes = areas[params[:area].to_sym].map { |v| v.to_s }
      @offers = @offers.joins(:address).where('addresses.area_code IN (?)', codes)
    end

    if @near_ids.present?
      @offers = @offers.where('offers.id IN (?)', @near_ids)
    end

    @offers = @offers
      .page(params[:page])
      .per(60)

    respond_to do |format|
      format.json { render template: 'offers/v2/search', status: :ok }
    end
  end

  private
    def offer_params
      if params[:arrival_date].present?
        params[:arrival_date] = Date.parse(params[:arrival_date].to_s)
      end

      if params[:departure_date].present?
        params[:departure_date] = Date.parse(params[:departure_date].to_s)
      end

      if params[:distance].present?
        params[:distance] = params[:distance].to_i
      end

      if params[:people_count].present?
        params[:people_count] = params[:people_count].to_i || 1
      end

      if params[:min_price].present?
        params[:min_price] = params[:min_price].to_i
      end

      if params[:max_price].present?
        params[:max_price] = params[:max_price].to_i
      end

      params
    end
end
