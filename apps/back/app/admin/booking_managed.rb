ActiveAdmin.register Booking, as: 'Managed Booking' do
  permit_params :offer_id, 
  :client_id, 
  :status, 
  :people_count, 
  :adult_count, 
  :child_count, 
  :arrival_date, 
  :departure_date, 
  :promo_code, 
  :farmer_deposit, 
  :stripe_token, 
  :breakfast_opt, 
  :cleaning_opt, 
  :linens_opt, 
  :annexe_services_total, 
  :panier_nb, 
  :panier_msg, 
  :panier_total, 
  :message, 
  :contact_number, 
  :managed, 
  :channel, 
  :commission_fee,
  :service_fee,
  :offer_price_per_night,
  :lodging_cost,
  :sub_total,
  :breakfast_opt,
  :linens_opt,
  :cleaning_opt,
  :total_services,
  :occupancy_tax,
  :promo_code,
  :total,
  :panier_nb,
  :panier_msg,
  :panier_total,
  :bike_rent_nb,
  :bike_rent_price,
  :bike_rent_msg,
  :breakfast_nb,
  :breakfast_price,
  :breakfast_msg,
  :packed_lunch_nb,
  :packed_lunch_price,
  :packed_lunch_msg,
  :cooking_workshop_nb,
  :cooking_workshop_price,
  :cooking_workshop_msg,
  :serenity_nb,
  :serenity_price,
  :serenity_msg,
  :spa_nb,
  :spa_price,
  :spa_msg,
  :car_rent_nb,
  :car_rent_price,
  :car_rent_msg,
  :station_ride_nb,
  :station_ride_price,
  :station_ride_msg,
  :animal_space_nb,
  :animal_space_price,
  :animal_space_msg,
  :host_table_nb,
  :host_table_price,
  :host_table_msg,
  :washing_kit_nb,
  :washing_kit_price,
  :washing_kit_msg,
  :bbq_nb,
  :bbq_price,
  :bbq_msg,
  :riding_lesson_nb,
  :riding_lesson_price,
  :riding_lesson_msg,
  :horse_ride_nb,
  :horse_ride_price,
  :horse_ride_msg,
  :riding_course_nb,
  :riding_course_price,
  :riding_course_msg,
  :riding_introduction_nb,
  :riding_introduction_price,
  :riding_introduction_msg,
  :immersion_nb,
  :immersion_price,
  :immersion_msg,
  :breakfast_opt,
  :cleaning_opt,
  :linens_opt,
  :annexe_services_total,
  :receipt_url,
  :housework,
  :housework_price,
  :created_at, 
  :updated_at

  controller do

    def create
      @booking = Booking.new(permitted_params[:booking])
      if @booking.save
        flash[:notice] = "Booking Managed created"
        redirect_to admin_managed_bookings_path
      else
        flash[:error] = @booking.errors.full_messages
        redirect_to new_admin_managed_booking_path
      end
    end

    def scoped_collection
      end_of_association_chain.includes(:offer).where(offers: { manager: true })
    end
  end

  batch_action :update_statut, form: {
    type: %w[pending confirmed declined cancelled payed finished]
  } do |ids, inputs|
    # inputs is a hash of all the form fields you requested
    batch_action_collection.find(ids).each do |booking|
      booking.update(status: inputs[:type])
    end
    redirect_to collection_path, alert: "The bookings status have been updated."
  end

  index do
    selectable_column
    column :id
    column :status
    column :client do |booking|
      link_to(booking.client.full_name, admin_client_path(booking.client.user)) unless booking.client.user.nil?
    end
    column :offer
    column :people_count
    column :arrival_date
    column :departure_date
    column :annexe_services_total
    column :total
    column :created_at
    column :updated_at
    actions
  end

  show do
    panel "Booking details" do
      attributes_table do
        row :id
        row :status
        row :client do |booking|
          link_to(booking.client.full_name, admin_client_path(booking.client.user)) unless booking.client.user.nil?
        end
        row :offer
        row :managed
        row :channel
        row :promo_code
        row :people_count
        row :adult_count
        row :child_count
        row :message
        row :contact_number
        row :arrival_date
        row :departure_date
        row :commission_fee
        row :service_fee
        row :offer_price_per_night
        row :lodging_cost
        row :sub_total
        row :breakfast_opt
        row :linens_opt
        row :cleaning_opt
        row :total_services
        row :panier_nb
        row :panier_msg
        row :panier_total
        row :bike_rent_nb
        row :bike_rent_price
        row :bike_rent_msg
        row :breakfast_nb
        row :breakfast_price
        row :breakfast_msg
        row :packed_lunch_nb
        row :packed_lunch_price
        row :packed_lunch_msg
        row :cooking_workshop_nb
        row :cooking_workshop_price
        row :cooking_workshop_msg
        row :serenity_nb
        row :serenity_price
        row :serenity_msg
        row :spa_nb
        row :spa_price
        row :spa_msg
        row :car_rent_nb
        row :car_rent_price
        row :car_rent_msg
        row :station_ride_nb
        row :station_ride_price
        row :station_ride_msg
        row :animal_space_nb
        row :animal_space_price
        row :animal_space_msg
        row :host_table_nb
        row :host_table_price
        row :host_table_msg
        row :washing_kit_nb
        row :washing_kit_price
        row :washing_kit_msg
        row :bbq_nb
        row :bbq_price
        row :bbq_msg
        row :riding_lesson_nb
        row :riding_lesson_price
        row :riding_lesson_msg
        row :horse_ride_nb
        row :horse_ride_price
        row :horse_ride_msg
        row :riding_course_nb
        row :riding_course_price
        row :riding_course_msg
        row :riding_introduction_nb
        row :riding_introduction_price
        row :riding_introduction_msg
        row :immersion_nb
        row :immersion_price
        row :immersion_msg
        row :occupancy_tax
        row :weekend_price do |booking|
          booking.weekend_price_calculus
        end
        row :breakfast_total
        row :cleaning_total
        row :linens_total
        row :annexe_services_total
        row :total
        row :farmer_deposit
        row :stripe_token
        row :receipt_url
        row :housework
        row :housework_price
        row :created_at
        row :updated_at
      end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.label "Offre:"
      f.select :offer_id, Offer.where(manager: true).collect { |o| [ o.name, o.id ] }, {}
      br
      br
      f.label "Client:"
      f.select :client_id, User.all.includes(:client).where.not(clients: { id: nil }).collect { |c| [ c.full_name, c.client.id ] }, {}
      br
      br
      f.input :status
      f.input :channel, collection: [['Abritel', 'Abritel'], ['Airbnb', 'Airbnb'], ['Cibevasion', 'Cibevasion'], ['Abracadraroom', 'Abracadraroom'], ['Leboncoin', 'Leboncoin'], ['Booking', 'Booking']]
      f.input :managed, label: "External Channel"
      f.input :housework, label: "Ménage à payer sur place"
      f.input :housework_price, label: "Prix du ménage à payer sur place"
      f.input :farmer_deposit, label: "Total versement à l'agriculteur"
      f.input :people_count
      f.input :adult_count
      f.input :child_count
      f.input :message
      f.input :contact_number
      f.input :arrival_date
      f.input :departure_date
      f.input :commission_fee
      f.input :service_fee
      f.input :offer_price_per_night
      f.input :lodging_cost
      f.input :sub_total
      f.input :breakfast_opt
      f.input :linens_opt
      f.input :cleaning_opt
      f.input :total_services
      f.input :occupancy_tax
      f.input :promo_code
      f.input :total
      f.input :panier_nb
      f.input :panier_msg
      f.input :panier_total
      f.input :bike_rent_nb
      f.input :bike_rent_price
      f.input :bike_rent_msg
      f.input :breakfast_nb
      f.input :breakfast_price
      f.input :breakfast_msg
      f.input :packed_lunch_nb
      f.input :packed_lunch_price
      f.input :packed_lunch_msg
      f.input :cooking_workshop_nb
      f.input :cooking_workshop_price
      f.input :cooking_workshop_msg
      f.input :serenity_nb
      f.input :serenity_price
      f.input :serenity_msg
      f.input :spa_nb
      f.input :spa_price
      f.input :spa_msg
      f.input :car_rent_nb
      f.input :car_rent_price
      f.input :car_rent_msg
      f.input :station_ride_nb
      f.input :station_ride_price
      f.input :station_ride_msg
      f.input :animal_space_nb
      f.input :animal_space_price
      f.input :animal_space_msg
      f.input :host_table_nb
      f.input :host_table_price
      f.input :host_table_msg
      f.input :washing_kit_nb
      f.input :washing_kit_price
      f.input :washing_kit_msg
      f.input :bbq_nb
      f.input :bbq_price
      f.input :bbq_msg
      f.input :riding_lesson_nb
      f.input :riding_lesson_price
      f.input :riding_lesson_msg
      f.input :horse_ride_nb
      f.input :horse_ride_price
      f.input :horse_ride_msg
      f.input :riding_course_nb
      f.input :riding_course_price
      f.input :riding_course_msg
      f.input :riding_introduction_nb
      f.input :riding_introduction_price
      f.input :riding_introduction_msg
      f.input :immersion_nb
      f.input :immersion_price
      f.input :immersion_msg
      f.input :annexe_services_total
      f.actions
    end
  end

  csv do
    column :id
    column :status
    column(:first_name) { |booking| booking.client.user.first_name unless booking.client.user.first_name.nil? }
    column(:last_name) { |booking| booking.client.user.last_name unless booking.client.user.last_name.nil? }
    column(:offer) { |booking| booking.offer.name unless booking.offer.nil? }
    column :promo_code
    column :people_count
    column :arrival_date
    column :departure_date
    column :commission_fee
    column :service_fee
    column :total
    column :farmer_deposit
    column :lodging_cost
    column :created_at
    column :updated_at
  end

end
