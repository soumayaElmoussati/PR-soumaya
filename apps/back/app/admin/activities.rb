ActiveAdmin.register Activity do
  permit_params :name, :slug, :state, :farmer_id, :people_count, :price_per_person, :additional_traveler_price, :additional_max_people, :max_people_count, :departure_time, :departure_min_time, :arriving_time, :arriving_min_time, :created_at, :updated_at,
  cloud_activity_pictures_attributes: [
    :_destroy,
    :id,
    :activity_id,
    :public_id,
    :url,
    :order
  ],
  activity_address_attributes: [
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
  activity_farm_type_attributes: [
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
  activity_agriculture_type_attributes: [
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
  activity_tag_attributes: [
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
  activity_animal_attributes: [
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
  activity_settlement_attributes: [
    :id,
    :baby_suitable,
    :child_suitable,
    :smooking_allowed,
    :parties_allowed,
    :accessible,
    :animals_Welcome,
    :additional_rules
  ],
  activity_description_attributes: [
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
  ]

  index do
    selectable_column
    column :id
    column :slug
    column :state
    column :name
    column :farmer do |activity|
      link_to(activity.farmer.full_name, admin_farmer_path(activity.farmer.user))
    end
    column :people_count
    column :price_per_person
    column :additional_traveler_price
    column :additional_max_people
    column :max_people_count
    column :postal_code do |activity|
      activity.activity_address.postal_code unless activity.activity_address.nil?
    end
    column :lat do |activity|
      activity.activity_address.lat unless activity.activity_address.nil?
    end
    column :lng do |activity|
      activity.activity_address.lng unless activity.activity_address.nil?
    end
    column :created_at
    column :updated_at
    actions
  end

  show do
    panel "Activity details" do
      attributes_table_for activity do
        row :id
        row :state
        row :name
        row :farmer do |activity|
          link_to(activity.farmer.full_name, admin_farmer_path(activity.farmer.user))
        end
        row :people_count
        row :price_per_person
        row :additional_traveler_price
        row :additional_max_people
        row :max_people_count
        row :arriving_time
        row :arriving_min_time
        row :departure_time
        row :departure_min_time
        row :activity_address do |activity|
          attributes_table_for activity.activity_address do
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

    panel "Activity cloud pictures" do
      table_for activity.cloud_activity_pictures, sortable: :order do
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

    panel "Activity Farm Type" do
      attributes_table_for activity.activity_farm_type do
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

    panel "Activity Agriculture Type" do
      attributes_table_for activity.activity_agriculture_type do
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

    panel "Activity Tags" do
      attributes_table_for activity.activity_tag do
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

    panel "Activity Animals" do
      attributes_table_for activity.activity_animal do
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

    panel "Activity Settlements" do
      attributes_table_for activity.activity_settlement do
        row :baby_suitable
        row :child_suitable
        row :smooking_allowed
        row :parties_allowed
        row :animals_welcome
        row :accessible
        row :additional_rules
      end
    end

    panel "Activity Description" do
      attributes_table_for activity.activity_description do
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

  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :state
      f.input :name
      f.input :farmer
      f.input :people_count
      f.input :price_per_person
      f.input :additional_traveler_price
      f.input :additional_max_people
      f.input :max_people_count
      f.input :departure_time
      f.input :departure_min_time
      f.input :arriving_time
      f.input :arriving_min_time
      f.inputs 'Address', for: [:activity_address, f.object.activity_address || ActivityAddress.new] do |activity_address|
        activity_address.input :id, :as => :hidden
        activity_address.input :name
        activity_address.input :street_name
        activity_address.input :city
        activity_address.input :postal_code
        activity_address.input :country_code
        activity_address.input :lat
        activity_address.input :lng
      end
      f.inputs 'Farm type', for: [:activity_farm_type, f.object.activity_farm_type || ActivityFarmType.new] do |activity_farm_type|
        activity_farm_type.input :id, :as => :hidden
        activity_farm_type.input :breeder
        activity_farm_type.input :cereal
        activity_farm_type.input :horticulturist
        activity_farm_type.input :market_gardener
        activity_farm_type.input :cheese_production
        activity_farm_type.input :winegrower
        activity_farm_type.input :brewer
        activity_farm_type.input :arborist
        activity_farm_type.input :oyster_farmer
        activity_farm_type.input :mushroom_grower
        activity_farm_type.input :beekeeper
        activity_farm_type.input :cider_maker
        activity_farm_type.input :riding_stable
        activity_farm_type.input :agroforestry
      end
      f.inputs 'Agriculture type', for: [:activity_agriculture_type, f.object.activity_agriculture_type || ActivityAgricultureType.new] do |activity_agriculture_type|
        activity_agriculture_type.input :id, :as => :hidden
        activity_agriculture_type.input :biological
        activity_agriculture_type.input :permaculture
        activity_agriculture_type.input :agroecology
        activity_agriculture_type.input :agroecological
        activity_agriculture_type.input :conventional
        activity_agriculture_type.input :ringing
        activity_agriculture_type.input :durable
        activity_agriculture_type.input :reliability
        activity_agriculture_type.input :hydroponics
      end
      f.inputs 'Tags', for: [:activity_tag, f.object.activity_tag || ActivityTag.new] do |activity_tag|
        activity_tag.input :id, :as => :hidden
        activity_tag.input :playful
        activity_tag.input :pedagogic
        activity_tag.input :unusual
        activity_tag.input :public
        activity_tag.input :gustatory
        activity_tag.input :animal
        activity_tag.input :dirty
        activity_tag.input :rewarding
        activity_tag.input :depth
        activity_tag.input :intensive
        activity_tag.input :quick
        activity_tag.input :physical
      end
      f.inputs 'Animals', for: [:activity_animal, f.object.activity_animal || ActivityAnimal.new] do |activity_animal|
        activity_animal.input :cow
        activity_animal.input :bee
        activity_animal.input :milk_cow
        activity_animal.input :sheep
        activity_animal.input :goat
        activity_animal.input :pig
        activity_animal.input :rabbit
        activity_animal.input :duck
        activity_animal.input :goose
        activity_animal.input :turkey
        activity_animal.input :chicken
        activity_animal.input :donkey
        activity_animal.input :snail
        activity_animal.input :horse
        activity_animal.input :lama
      end
      f.inputs 'Settlements', for: [:activity_settlement, f.object.activity_settlement || ActivitySettlement.new] do |activity_settlement|
        activity_settlement.input :baby_suitable
        activity_settlement.input :child_suitable
        activity_settlement.input :smooking_allowed
        activity_settlement.input :parties_allowed
        activity_settlement.input :animals_welcome
        activity_settlement.input :accessible
        activity_settlement.input :additional_rules
      end
      f.inputs 'Description', for: [:activity_description, f.object.activity_description || ActivityDescription.new] do |activity_description|
        activity_description.input :id, :as => :hidden
        activity_description.input :residence
        activity_description.input :farm
        activity_description.input :activities
        activity_description.input :farmer
        activity_description.input :discovery
        activity_description.input :meeting_animals
        activity_description.input :milking_animals
        activity_description.input :tasting
        activity_description.input :birth_animal
        activity_description.input :stroll
        activity_description.input :harvest
        activity_description.input :craft
      end
      f.has_many :cloud_activity_pictures do |a|
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


end
