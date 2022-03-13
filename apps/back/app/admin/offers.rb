ActiveAdmin.register Offer do
  permit_params :name, :slug, :people_count, :inverseur_percentage, :residence_type, :manager, :instant_booking, :price_per_person, :farmer_id, :additional_max_people, :min_days, :additional_traveler_price, :deposit, :max_people_count, :toilets_count, :sleeps_count, :bathrooms_count, :rooms_count, :departure_time, :departure_min_time, :arriving_time, :arriving_min_time, :state, :certificated, :product_token, :tourist_tax, :annexe_information, :created_at, :updated_at,
  icalendar_urls: [],
    offer_description_attributes: [
      :id,
      :farm,
      :farmer,
      :residence,
      :activities,
      :discovery,
      :meeting_animals,
      :milking_animals,
      :tasting,
      :birth_animal,
      :stroll,
      :harvest,
      :craft
    ],
    offer_farm_type_attributes: [
      :id,
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
    offer_agriculture_type_attributes: [
      :id,
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
    offer_adjectif_attributes: [
      :id,
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
    offer_benefit_attributes: [
      :id,
      :cleaning_kit,
      :toilet_paper,
      :soap,
      :household_linen
    ],
    offer_tag_attributes: [
      :id,
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
    offer_equipment_attributes: [
      :id,
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
      :freezer,
      :deep_freezer,
      :garage,
      :secure_local,
      :train
    ],
    offer_animal_attributes: [
      :id,
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
    ],
    offer_settlement_attributes: [
      :id,
      :baby_suitable,
      :child_suitable,
      :smooking_allowed,
      :parties_allowed,
      :accessible,
      :animals_welcome,
      :additional_rules
    ],
    annexe_services_attributes: [
      :id,
      :_destroy,
      :name,
      :description,
      :price,
      :unity
    ],
    address_attributes: [
      :id,
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
    offer_rooms_attributes: [
      :_destroy,
      :id,
      :simple_bed,
      :double_bed,
      :private_bathroom
    ],
    cloud_pictures_attributes: [
      :_destroy,
      :id,
      :offer_id,
      :public_id,
      :url,
      :order
    ],
    offer_price_weekend_attributes: [
      :id,
      :price,
      :both_days
    ],
    offer_service_attributes: [
      :id,
      :breakfast,
      :breakfast_price,
      :linens,
      :linens_price,
      :esprit_ferme,
      :esprit_link,
      :host_table,
      :host_table_price,
      :cleaning,
      :cleaning_price,
      :breakfastopt,
      :linensopt,
      :cleaningopt
    ],
    offer_promotions_attributes: [
      :_destroy,
      :id,
      :start_date,
      :end_date,
      :amount,
      :statut
    ],
    offer_price_periods_attributes: [
      :_destroy,
      :id,
      :start_date,
      :end_date,
      :min_days,
      :use_discount,
      :price_period
    ],
    offer_price_discounts_attributes: [
      :_destroy,
      :id,
      :percentage_discount,
      :min_nights
    ],
    offer_events_attibutes: [
      :_destroy,
      :id,
      :arrival_date,
      :departure_date,
      :offer_id,
      :booking_id,
      :status
    ],
    expenses_attributes: [
      :_destroy,
      :id,
      :responsable,
      :expense_date,
      :total_ttc,
      :total_ht,
      :comment
    ]

  member_action :clone, method: :get do
    offer = Offer.find(params[:id])
    @offer = offer.deep_clone include: [:address,:offer_description, :offer_farm_type, :offer_agriculture_type, :offer_adjectif, :offer_tag, :offer_equipment, :offer_animal, :offer_settlement, :offer_service, :offer_price_weekend, :offer_price_periods, :offer_price_discounts]

    render :new, layout: false
  end

  index do
    selectable_column
    column :id
    column :state
    column :certificated
    column :name
    column :slug
    column :farmer do |offer|
      link_to(offer.farmer.full_name, admin_farmer_path(offer.farmer.user))
    end
    column :people_count
    column :price_per_person
    column :postal_code do |offer|
      offer.address.postal_code unless offer.address.nil?
    end
    column :lat do |offer|
      offer.address.lat unless offer.address.nil?
    end
    column :lng do |offer|
      offer.address.lng unless offer.address.nil?
    end
    column 'Price Periods' do |offer|
      offer.offer_price_periods.count
    end
    column 'Discounts' do |offer|
      offer.offer_price_discounts.count
    end
    column :product_token
    column :created_at
    column :updated_at
    column :icalendar_urls
    actions defaults: true do |offer|
      link_to 'Dupliquer', clone_admin_offer_path(id: offer.id)
    end
  end

  show do
    panel "Offer details" do
      attributes_table_for offer do
        row :id
        row :state
        row :certificated
        row :manager
        row :instant_booking
        row :name
        row :slug
        row :inverseur_percentage
        row :icalendar_urls
        row :farmer do |offer|
          link_to(offer.farmer.full_name, admin_farmer_path(offer.farmer.user))
        end
        row :price_per_person, :label => "Prix de base du logement"
        row :people_count
        row :tourist_tax
        row :additional_traveler_price
        row :additional_max_people
        row :deposit
        row :annexe_information
        row :min_days
        row :max_people_count
        row :toilets_count
        row :sleeps_count
        row :bathrooms_count
        row :rooms_count
        row :departure_time
        row :departure_min_time
        row :arriving_time
        row :arriving_min_time
        row :product_token
        row :address do |offer|
          attributes_table_for offer.address do
            row :street_name
            row :city
            row :postal_code
            row :area_code
            row :country_code
          end
        end
        row :created_at
        row :updated_at
      end
    end

    panel "Offer Description" do
      attributes_table_for offer.offer_description do
        row :residence
        row :farm
        row :activities
        row :farmer
        row :discovery
        row :meeting_animals
        row :milking_animals
        row :tasting
        row :birth_animal
        row :stroll
        row :harvest
        row :craft
      end
    end

    panel "Offer Farm Type" do
      attributes_table_for offer.offer_farm_type do
        row :breeder
        row :cereal
        row :horticulturist
        row :market_gardener
        row :cheese_production
        row :winegrower
        row :brewer
        row :arborist
        row :oyster_farmer
        row :mushroom_grower
        row :beekeeper
        row :cider_maker
        row :riding_stable
        row :agroforestry
      end
    end

    panel "Offer Agriculture Type" do
      attributes_table_for offer.offer_agriculture_type do
        row :biological
        row :permaculture
        row :agroecology
        row :agroecological
        row :conventional
        row :ringing
        row :durable
        row :reliability
        row :hydroponics
      end
    end

    panel "Offer Adjectifs" do
      attributes_table_for offer.offer_adjectif do
        row :rustic
        row :luxurious
        row :confortable
        row :clean
        row :friendly
        row :calm
        row :exotic
        row :romantic
        row :cheap
        row :insolit
        row :simple
        row :luminous
      end
    end

    panel "Offer Tags" do
      attributes_table_for offer.offer_tag do
        row :playful
        row :pedagogic
        row :unusual
        row :public
        row :gustatory
        row :animal
        row :dirty
        row :rewarding
        row :depth
        row :intensive
        row :quick
        row :physical
      end
    end

    panel "Offer Equiments" do
      attributes_table_for offer.offer_equipment do
        row :kitchen
        row :wifi
        row :tv
        row :washing_machine
        row :fireplace
        row :parking
        row :swimming_pool
        row :domestic_animals
        row :english_speaking
        row :internet
        row :dvd_player
        row :games
        row :dryer
        row :hair_dryer
        row :drying_rack
        row :iron
        row :wardrobe
        row :shower
        row :bath
        row :baby_bath
        row :heater
        row :clim
        row :fitness
        row :garden_lounge
        row :bbq
        row :oven
        row :hotplates
        row :microwaves
        row :toaster
        row :kettle
        row :coffee_machine
        row :cutlery
        row :dishwasher
        row :baby_chair
        row :fridge
        row :freezer
        row :deep_freezer
        row :garage
        row :secure_local
        row :train
      end
    end

    panel "Offer Animals" do
      attributes_table_for offer.offer_animal do
        row :cow
        row :bee
        row :milk_cow
        row :sheep
        row :goat
        row :pig
        row :rabbit
        row :duck
        row :goose
        row :turkey
        row :chicken
        row :donkey
        row :snail
        row :horse
        row :lama
      end
    end

    panel "Offer Settlements" do
      attributes_table_for offer.offer_settlement do
        row :baby_suitable
        row :child_suitable
        row :smooking_allowed
        row :parties_allowed
        row :animals_welcome
        row :accessible
        row :additional_rules
      end
    end

    panel "Offer Annexe Services" do
      attributes_table_for offer.annexe_services do
        row :name
        row :price
        row :unity
        row :description
      end
    end

    panel "Offer bedrooms" do
      table_for offer.offer_rooms do
        column :simple_bed
        column :double_bed
        column :private_bathroom
      end
    end

    panel "Offer Services" do
      attributes_table_for offer.offer_service do
        row :breakfast
        row :breakfast_price
        row :linens
        row :linens_price
        row :host_table
        row :host_table_price
        row :esprit_ferme
        row :esprit_link
        row :cleaning
        row :cleaning_price
        row :breakfastopt
        row :linensopt
        row :cleaningopt
      end
    end

    panel "Offer Benefits" do
      attributes_table_for offer.offer_benefit do
        row :cleaning_kit
        row :toilet_paper
        row :soap
        row :household_linen
      end
    end

    panel "Offer Price Weekend" do
      attributes_table_for offer.offer_price_weekend do
        row :price
        row :both_days
      end
    end

    panel "Offer price period" do
      table_for offer.offer_price_periods do
        column :id
        column :start_date
        column :end_date
        column :min_days
        column :use_discount
        column :price_period
      end
    end

    panel "Offer Promotion" do
      table_for offer.offer_promotions do
        column :id
        column :start_date
        column :end_date
        column :amount
        column :statut
      end
    end

    panel "Offer price discount" do
      table_for offer.offer_price_discounts do
        column :id
        column :percentage_discount
        column :min_nights
      end
    end

    panel "Offer cloud pictures" do
      table_for offer.cloud_pictures, sortable: :order do
        column :id
        column :order
        # column :picture do |picture|
        #   image_tag picture.image_url(:thumbnail)
        # end
        column :image do |image|
          cl_image_tag(image.public_id, :width => 140, :height => 90, :crop => :fill)
        end
      end
    end

    panel "Offer exploitation cloud pictures" do
      table_for offer.cloud_offer_pictures, sortable: :order do
        column :id
        column :order
        # column :picture do |picture|
        #   image_tag picture.image_url(:thumbnail)
        # end
        column :image do |image|
          cl_image_tag(image.public_id, :width => 140, :height => 90, :crop => :fill)
        end
      end
    end

    panel "Offer events" do
      table_for offer.events, sortable: :order do
        column :id
        column :arrival_date
        column :departure_date
        column :offer_id
        column :booking_id
        column :offer_status
      end
    end

    panel "Expenses" do
      table_for offer.expenses do
        column :id
        column :responsable
        column :expense_date
        column :total_ht
        column :total_ttc
        column :comment
      end
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :state
      f.input :certificated
      f.input :manager
      f.input :instant_booking
      f.input :farmer
      f.input :name
      f.input :slug
      f.input :inverseur_percentage
      f.input :icalendar_urls, :input_html => {:maxlength => nil}
      f.input :people_count
      f.input :residence_type
      f.input :price_per_person
      f.input :people_count
      f.input :tourist_tax
      f.input :additional_traveler_price
      f.input :additional_max_people
      f.input :deposit
      f.input :annexe_information
      f.input :min_days
      f.input :max_people_count
      f.input :toilets_count
      f.input :sleeps_count
      f.input :bathrooms_count
      f.input :rooms_count
      f.input :departure_time
      f.input :departure_min_time
      f.input :arriving_time
      f.input :arriving_min_time
      f.inputs 'Description', for: [:offer_description, f.object.offer_description || OfferDescription.new] do |offer_description|
        offer_description.input :id, :as => :hidden
        offer_description.input :residence
        offer_description.input :farm
        offer_description.input :activities
        offer_description.input :farmer
        offer_description.input :discovery
        offer_description.input :meeting_animals
        offer_description.input :milking_animals
        offer_description.input :tasting
        offer_description.input :birth_animal
        offer_description.input :stroll
        offer_description.input :harvest
        offer_description.input :craft
      end
      f.inputs 'Farm type', for: [:offer_farm_type, f.object.offer_farm_type || OfferFarmType.new] do |offer_farm_type|
        offer_farm_type.input :id, :as => :hidden
        offer_farm_type.input :breeder
        offer_farm_type.input :cereal
        offer_farm_type.input :horticulturist
        offer_farm_type.input :market_gardener
        offer_farm_type.input :cheese_production
        offer_farm_type.input :winegrower
        offer_farm_type.input :brewer
        offer_farm_type.input :arborist
        offer_farm_type.input :oyster_farmer
        offer_farm_type.input :mushroom_grower
        offer_farm_type.input :beekeeper
        offer_farm_type.input :cider_maker
        offer_farm_type.input :riding_stable
        offer_farm_type.input :agroforestry
      end
      f.inputs 'Agriculture type', for: [:offer_agriculture_type, f.object.offer_agriculture_type || OfferAgricultureType.new] do |offer_agriculture_type|
        offer_agriculture_type.input :id, :as => :hidden
        offer_agriculture_type.input :biological
        offer_agriculture_type.input :permaculture
        offer_agriculture_type.input :agroecology
        offer_agriculture_type.input :agroecological
        offer_agriculture_type.input :conventional
        offer_agriculture_type.input :ringing
        offer_agriculture_type.input :durable
        offer_agriculture_type.input :reliability
        offer_agriculture_type.input :hydroponics
      end
      f.inputs 'Adjectifs', for: [:offer_adjectif, f.object.offer_adjectif || OfferAdjectif.new] do |offer_adjectif|
        offer_adjectif.input :id, :as => :hidden
        offer_adjectif.input :rustic
        offer_adjectif.input :luxurious
        offer_adjectif.input :confortable
        offer_adjectif.input :clean
        offer_adjectif.input :friendly
        offer_adjectif.input :calm
        offer_adjectif.input :exotic
        offer_adjectif.input :romantic
        offer_adjectif.input :cheap
        offer_adjectif.input :insolit
        offer_adjectif.input :simple
        offer_adjectif.input :luminous
      end
      f.inputs 'Tags', for: [:offer_tag, f.object.offer_tag || OfferTag.new] do |offer_tag|
        offer_tag.input :id, :as => :hidden
        offer_tag.input :playful
        offer_tag.input :pedagogic
        offer_tag.input :unusual
        offer_tag.input :public
        offer_tag.input :gustatory
        offer_tag.input :animal
        offer_tag.input :dirty
        offer_tag.input :rewarding
        offer_tag.input :depth
        offer_tag.input :intensive
        offer_tag.input :quick
        offer_tag.input :physical
      end
      f.inputs 'Equipments', for: [:offer_equipment, f.object.offer_equipment || OfferEquipment.new] do |offer_equipment|
        offer_equipment.input :id, :as => :hidden
        offer_equipment.input :kitchen
        offer_equipment.input :wifi
        offer_equipment.input :tv
        offer_equipment.input :washing_machine
        offer_equipment.input :fireplace
        offer_equipment.input :parking
        offer_equipment.input :swimming_pool
        offer_equipment.input :domestic_animals
        offer_equipment.input :english_speaking
        offer_equipment.input :private_garden
        offer_equipment.input :shared_garden
        offer_equipment.input :internet
        offer_equipment.input :dvd_player
        offer_equipment.input :games
        offer_equipment.input :dryer
        offer_equipment.input :hair_dryer
        offer_equipment.input :drying_rack
        offer_equipment.input :iron
        offer_equipment.input :wardrobe
        offer_equipment.input :shower
        offer_equipment.input :bath
        offer_equipment.input :baby_bath
        offer_equipment.input :heater
        offer_equipment.input :clim
        offer_equipment.input :fitness
        offer_equipment.input :garden_lounge
        offer_equipment.input :bbq
        offer_equipment.input :oven
        offer_equipment.input :hotplates
        offer_equipment.input :microwaves
        offer_equipment.input :toaster
        offer_equipment.input :kettle
        offer_equipment.input :coffee_machine
        offer_equipment.input :cutlery
        offer_equipment.input :dishwasher
        offer_equipment.input :baby_chair
        offer_equipment.input :fridge
        offer_equipment.input :freezer
        offer_equipment.input :deep_freezer
        offer_equipment.input :garage
        offer_equipment.input :secure_local
        offer_equipment.input :train
      end
      f.inputs 'Animals', for: [:offer_animal, f.object.offer_animal || OfferAnimal.new] do |offer_animal|
        offer_animal.input :cow
        offer_animal.input :bee
        offer_animal.input :milk_cow
        offer_animal.input :sheep
        offer_animal.input :goat
        offer_animal.input :pig
        offer_animal.input :rabbit
        offer_animal.input :duck
        offer_animal.input :goose
        offer_animal.input :turkey
        offer_animal.input :chicken
        offer_animal.input :donkey
        offer_animal.input :snail
        offer_animal.input :horse
        offer_animal.input :lama
      end
      f.inputs 'Settlements', for: [:offer_settlement, f.object.offer_settlement || OfferSettlement.new] do |offer_settlement|
        offer_settlement.input :baby_suitable
        offer_settlement.input :child_suitable
        offer_settlement.input :smooking_allowed
        offer_settlement.input :parties_allowed
        offer_settlement.input :animals_welcome
        offer_settlement.input :accessible
        offer_settlement.input :additional_rules
      end
      f.has_many :annexe_services do |a|
        unless a.object.new_record?
          a.input :_destroy, :as => :boolean, :required => false, :label => "Delete this annexe service"
        end
        a.input :name, :as => :select, collection: (['Panier garnis', 'Location de vélo', 'Panier repas', 'Atelier cuisine', 'Activité bien-être', 'Accès SPA', 'Location de voiture', 'Trajet gare-ferme', 'Petit déjeuner', 'Espace nuit pour animaux', 'Table d\'hôte', 'Lave-linge / sèche-linge', 'Barbecue', 'Cours d\'équitation', 'Balade à cheval / en âne', 'Stage d\'équitation', 'Initiation à l\'équitation', 'Immersion à la ferme'])
        a.input :price
        a.input :unity
        a.input :description
      end
      f.inputs 'Services', for: [:offer_service, f.object.offer_service || OfferService.new] do |offer_service|
        offer_service.input :id, :as => :hidden
        offer_service.input :breakfast
        offer_service.input :breakfast_price
        offer_service.input :linens
        offer_service.input :linens_price
        offer_service.input :host_table
        offer_service.input :host_table_price
        offer_service.input :esprit_ferme
        offer_service.input :esprit_link
        offer_service.input :cleaning
        offer_service.input :cleaning_price
        offer_service.input :breakfastopt
        offer_service.input :linensopt
        offer_service.input :cleaningopt
      end
      f.inputs 'Benefits', for: [:offer_benefit, f.object.offer_benefit || OfferBenefit.new] do |offer_benefit|
        offer_benefit.input :id, :as => :hidden
        offer_benefit.input :cleaning_kit
        offer_benefit.input :toilet_paper
        offer_benefit.input :soap
        offer_benefit.input :household_linen
      end
      f.inputs 'Address', for: [:address, f.object.address || Address.new] do |address|
        address.input :id, :as => :hidden
        address.input :name
        address.input :street_name
        address.input :city
        address.input :postal_code
        address.input :country_code
        address.input :lat
        address.input :lng
      end
      f.has_many :expenses do |a|
        unless a.object.new_record?
          a.input :_destroy, :as => :boolean, :required => false, :label => "Delete this expense"
        end
        a.input :responsable, :as => :select, collection: (['Agriculteur', 'AgriVillage'])
        a.input :expense_date
        a.input :total_ht
        a.input :total_ttc
        a.input :comment
      end
      f.inputs 'Offer Price Weekend', for: [:offer_price_weekend, f.object.offer_price_weekend || OfferPriceWeekend.new] do |offer_price_weekend|
        offer_price_weekend.input :id, :as => :hidden
        offer_price_weekend.input :price
        offer_price_weekend.input :both_days
      end
      f.has_many :offer_promotions do |a|
        unless a.object.new_record?
          a.input :_destroy, :as => :boolean, :required => false, :label => "Delete this promotion"
        end
        a.input :start_date
        a.input :end_date
        a.input :amount
        a.input :statut
      end
      f.has_many :offer_price_periods do |a|
        unless a.object.new_record?
          a.input :_destroy, :as => :boolean, :required => false, :label => "Delete this discount period"
        end
        a.input :start_date
        a.input :end_date
        a.input :min_days
        a.input :use_discount
        a.input :price_period
      end
      f.has_many :offer_price_discounts do |a|
        unless a.object.new_record?
          a.input :_destroy, :as => :boolean, :required => false, :label => "Delete this discount price"
        end
        a.input :percentage_discount
        a.input :min_nights
      end
      f.has_many :offer_rooms do |a|
        unless a.object.new_record?
          a.input :_destroy, :as => :boolean, :required => false, :label => "Delete this room"
        end
        a.input :simple_bed
        a.input :double_bed
        a.input :private_bathroom
      end
      f.has_many :cloud_pictures do |a|
        unless a.object.new_record?
          a.input :_destroy, :as => :boolean, :required => false, :label => "Delete this picture"
        end
        # a.input :image, :as => :file, :hint => "https://res.cloudinary.com/agrivillage/image/upload/qxfupljmxm0yuyfcoiqx"
        a.input :local_image, :as => :file, :hint => cl_image_tag(a.object.public_id, :width => 140, :height => 90, :crop => :fill)
        # a.input :url, :as => :file, :hint => image_tag(
        #   a.object.url.image_url(:thumbnail)
        # )
        a.input :order
      end
      f.actions
    end
  end

  controller do
    def update(options={}, &block)

      params[:offer][:icalendar_urls] = params[:offer][:icalendar_urls].split(' ')

      super do |success, failure|
        block.call(success, failure) if block
        failure.html { render :show}
      end



      @offer = Offer.find(params[:id])

      (params[:offer][:cloud_pictures_attributes] || []).each do |item|
        if !item[1][:local_image].nil?
          res = Cloudinary::Uploader.upload(item[1][:local_image])
          @picture = @offer.cloud_pictures.create()
          @picture.update_column(:order, item[1][:order])
          @picture.update_column(:public_id, res["public_id"])
          @picture.update_column(:url, "https://res.cloudinary.com/agrivillage/image/upload/" + res["public_id"])
        end
      end

      @old_pictures = @offer.cloud_pictures.each_with_index.sort_by {|h, idx| [h.order, idx] }.map(&:first)
      @offer.cloud_pictures.clear
      @old_pictures.each do |picture|
        @picture = @offer.cloud_pictures.create(:order => picture[:order], :public_id => picture[:public_id], :url => picture[:url])
      end

      @offer.cloud_pictures.each do |picture|
        if picture.public_id.nil?
          picture.destroy
        end
      end

    end
  end

  csv do
    column :id
    column :name
    column :slug
    column :state
    column :residence_type
    column :certificated
    column :price_per_person
    column :created_at
    column(:first_name) { |offer| offer.farmer.user.first_name unless offer.farmer.nil? }
    column(:last_name) { |offer| offer.farmer.user.last_name unless offer.farmer.nil? }
    column(:street_name) { |offer| offer.address.street_name unless offer.address.nil? }
    column(:postal_code) { |offer| offer.address.postal_code unless offer.address.nil? }
    column(:city) { |offer| offer.address.city unless offer.address.nil? }
    column(:url) { |offer| offer.cloud_pictures.first.url unless offer.cloud_pictures.first.nil? }
  end

end
