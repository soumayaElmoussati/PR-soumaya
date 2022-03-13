require 'faker'

if Rails.env.development? || Rails.env.staging?
  hasAdmin = User.where(email: 'admin@example.com')
  if hasAdmin.count === 0
    begin
      email = 'admin@example.com'
      password = 'password'

      user = User.create(
        first_name: 'Admin',
        last_name: 'Admin',
        password: password,
        password_confirmation: password,
        email: email,
        cellphone: Faker::PhoneNumber.cell_phone,
        phone: Faker::PhoneNumber.phone_number
      )

      user.skip_confirmation!

      Admin.create(
        user: user
      )
    rescue => e
      puts "Error create admin user", e
    end
    puts "Create admin user"
  end

  # Create some farmers
  puts "Creating farmers..."
  10.times do
    puts "Creating farmer here.."
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name

    begin
      user = User.create(
        first_name: first_name,
        last_name: last_name,
        password: 'password',
        password_confirmation: 'password',
        email: Faker::Internet.safe_email(name: "#{first_name} #{last_name}"),
        cellphone: Faker::PhoneNumber.cell_phone,
        phone: Faker::PhoneNumber.phone_number
      )

      if !user.nil?
        puts "Farmer here?", user
        farmer = Farmer.create(
          user: user
        )
      else
        puts "No user found"
      end
    rescue => e
      puts "Error occured while creating user: #{e}"
    end
  end

  # Create some clients
  # 10.times do
  #   first_name = Faker::Name.first_name
  #   last_name = Faker::Name.last_name

  #   user = User.new(
  #     first_name: first_name,
  #     last_name: last_name,
  #     password: 'password',
  #     password_confirmation: 'password',
  #     email: Faker::Internet.safe_email(name: "#{first_name} #{last_name}"),
  #     birthdate: Faker::Date.between(from: 32.years.ago, to: 18.years.ago)
  #   )

  #   client = Client.create(
  #     user: user
  #   )
  # end

  # Create some offers
  puts "Creating some offers..."
  20.times do
    address = Address.new(
      street_name: Faker::Address.street_name,
      city: Faker::Address.city,
      state: Faker::Address.state,
      postal_code: Faker::Address.postcode,
      country_code: Faker::Address.country_code,
      lat: Faker::Address.latitude,
      lng: Faker::Address.longitude
    )

    offer_name = Faker::Company.name

    offer = Offer.new(
      state: Offer.states[:published],
      farmer: Farmer.offset(rand(Farmer.count)).first,
      name: offer_name,
      slug: offer_name.parameterize,
      address: address,
      certificated: false,
      people_count: Faker::Number.between(from: 1, to: 10).round,
      residence_type: 1,
      price_per_person: Faker::Number.between(from: 1000, to: 40000).round,
      additional_max_people: Faker::Number.between(from: 1, to: 3).round
    )

    offer_description = OfferDescription.new(
      offer: offer,
      farmer: Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 10, to: 30).round),
      residence: Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 10, to: 30).round),
      farm: Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 10, to: 30).round),
      activities: Faker::Lorem.paragraph(sentence_count: Faker::Number.between(from: 10, to: 30).round),
      discovery: Faker::Boolean.boolean,
      meeting_animals: Faker::Boolean.boolean,
      milking_animals: Faker::Boolean.boolean,
      tasting: Faker::Boolean.boolean,
      birth_animal: Faker::Boolean.boolean,
      stroll: Faker::Boolean.boolean,
      harvest: Faker::Boolean.boolean,
      craft: Faker::Boolean.boolean
    )

    offer_equipment = OfferEquipment.new(
      offer: offer,
      kitchen: Faker::Boolean.boolean,
      wifi: Faker::Boolean.boolean,
      tv: Faker::Boolean.boolean,
      washing_machine: Faker::Boolean.boolean,
      fireplace: Faker::Boolean.boolean,
      parking: Faker::Boolean.boolean,
      swimming_pool: Faker::Boolean.boolean,
      domestic_animals: Faker::Boolean.boolean,
      english_speaking: Faker::Boolean.boolean,
      private_garden: Faker::Boolean.boolean,
      shared_garden: Faker::Boolean.boolean,
      internet: Faker::Boolean.boolean,
      dvd_player: Faker::Boolean.boolean,
      games: Faker::Boolean.boolean,
      dryer: Faker::Boolean.boolean,
      hair_dryer: Faker::Boolean.boolean,
      drying_rack: Faker::Boolean.boolean,
      iron: Faker::Boolean.boolean,
      wardrobe: Faker::Boolean.boolean,
      shower: Faker::Boolean.boolean,
      bath: Faker::Boolean.boolean,
      baby_bath: Faker::Boolean.boolean,
      heater: Faker::Boolean.boolean,
      clim: Faker::Boolean.boolean,
      fitness: Faker::Boolean.boolean,
      garden_lounge: Faker::Boolean.boolean,
      bbq: Faker::Boolean.boolean,
      oven: Faker::Boolean.boolean,
      hotplates: Faker::Boolean.boolean,
      microwaves: Faker::Boolean.boolean,
      toaster: Faker::Boolean.boolean,
      kettle: Faker::Boolean.boolean,
      coffee_machine: Faker::Boolean.boolean,
      cutlery: Faker::Boolean.boolean,
      dishwasher: Faker::Boolean.boolean,
      baby_chair: Faker::Boolean.boolean,
      fridge: Faker::Boolean.boolean,
      freezer: Faker::Boolean.boolean,
      deep_freezer: Faker::Boolean.boolean,
      garage: Faker::Boolean.boolean,
      secure_local: Faker::Boolean.boolean,
      train: Faker::Boolean.boolean
    )

    offer_animal = OfferAnimal.new(
      offer: offer,
      cow: Faker::Boolean.boolean,
      bee: Faker::Boolean.boolean,
      milk_cow: Faker::Boolean.boolean,
      sheep: Faker::Boolean.boolean,
      goat: Faker::Boolean.boolean,
      pig: Faker::Boolean.boolean,
      rabbit: Faker::Boolean.boolean,
      duck: Faker::Boolean.boolean,
      goose: Faker::Boolean.boolean,
      turkey: Faker::Boolean.boolean,
      chicken: Faker::Boolean.boolean,
      donkey: Faker::Boolean.boolean,
      snail: Faker::Boolean.boolean,
      horse: Faker::Boolean.boolean,
      lama: Faker::Boolean.boolean
    )

    offer_settlement = OfferSettlement.new(
      offer: offer,
      baby_suitable: Faker::Boolean.boolean,
      child_suitable: Faker::Boolean.boolean,
      smooking_allowed: Faker::Boolean.boolean,
      parties_allowed: Faker::Boolean.boolean,
      animals_welcome: Faker::Boolean.boolean,
      accessible: Faker::Boolean.boolean,
      additional_rules: Faker::Lorem.paragraph(sentence_count: 10),
    )

    offer_service = OfferService.new(
      offer: offer,
      breakfast: Faker::Boolean.boolean,
      linens: Faker::Boolean.boolean,
      host_table: Faker::Boolean.boolean,
      esprit_ferme: Faker::Boolean.boolean,
      cleaning: Faker::Boolean.boolean
    )

    offer_farm_types = OfferFarmType.new(
      offer: offer,
      breeder: Faker::Boolean.boolean,
      cereal: Faker::Boolean.boolean,
      horticulturist: Faker::Boolean.boolean,
      market_gardener: Faker::Boolean.boolean,
      cheese_production: Faker::Boolean.boolean,
      winegrower: Faker::Boolean.boolean,
      brewer: Faker::Boolean.boolean,
      arborist: Faker::Boolean.boolean,
      oyster_farmer: Faker::Boolean.boolean,
      mushroom_grower: Faker::Boolean.boolean,
      beekeeper: Faker::Boolean.boolean,
      cider_maker: Faker::Boolean.boolean,
      riding_stable: Faker::Boolean.boolean,
      agroforestry: Faker::Boolean.boolean
    )

    offer_agriculture_types = OfferAgricultureType.new(
      offer: offer,
      biological: Faker::Boolean.boolean,
      permaculture: Faker::Boolean.boolean,
      agroecology: Faker::Boolean.boolean,
      agroecological: Faker::Boolean.boolean,
      conventional: Faker::Boolean.boolean,
      ringing: Faker::Boolean.boolean,
      durable: Faker::Boolean.boolean,
      reliability: Faker::Boolean.boolean,
      hydroponics: Faker::Boolean.boolean
    )

    offer_adjectifs = OfferAdjectif.new(
      offer: offer,
      rustic: Faker::Boolean.boolean,
      luxurious: Faker::Boolean.boolean,
      confortable: Faker::Boolean.boolean,
      clean: Faker::Boolean.boolean,
      friendly: Faker::Boolean.boolean,
      calm: Faker::Boolean.boolean,
      exotic: Faker::Boolean.boolean,
      romantic: Faker::Boolean.boolean,
      cheap: Faker::Boolean.boolean,
      insolit: Faker::Boolean.boolean,
      simple: Faker::Boolean.boolean,
      luminous: Faker::Boolean.boolean
    )

    offer_tags = OfferTag.new(
      offer: offer,
      playful: Faker::Boolean.boolean,
      pedagogic: Faker::Boolean.boolean,
      unusual: Faker::Boolean.boolean,
      public: Faker::Boolean.boolean,
      gustatory: Faker::Boolean.boolean,
      animal: Faker::Boolean.boolean,
      dirty: Faker::Boolean.boolean,
      rewarding: Faker::Boolean.boolean,
      depth: Faker::Boolean.boolean,
      intensive: Faker::Boolean.boolean,
      quick: Faker::Boolean.boolean,
      physical: Faker::Boolean.boolean
    )

    number_of_rooms = Faker::Number.between(from: 0, to: 3).round
    number_of_rooms.times do
      room = OfferRoom.new(
        offer: offer,
        simple_bed: Faker::Number.between(from: 0, to: 3).round,
        double_bed: Faker::Number.between(from: 0, to: 3).round,
        private_bathroom: Faker::Boolean.boolean
      )
    end

    offer.save!
  end
end
