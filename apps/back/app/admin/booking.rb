ActiveAdmin.register Booking do
  permit_params :status, :people_count, :adult_count, :child_count, :arrival_date, :departure_date, :promo_code, :farmer_deposit, :stripe_token, :breakfast_opt, :cleaning_opt, :linens_opt, :annexe_services_total, :panier_nb, :panier_msg, :panier_total, :message, :contact_number, :managed, :channel, :breakfast_total, :linens_total, :linens_total, :receipt_url, :created_at, :updated_at

  controller do
    def scoped_collection
      end_of_association_chain.includes(:offer).where.not(offers: { manager: true })
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
    column :promo_code
    column :people_count
    column :arrival_date
    column :departure_date
    column :commission_fee
    column :service_fee
    column :annexe_services_total
    column :total
    column :farmer_deposit
    column :lodging_cost
    column :created_at
    column :updated_at
    actions
  end

  show do
    panel "Booking details" do
      attributes_table_for booking do
        row :id
        row :status
        row :client do |booking|
          link_to(booking.client.full_name, admin_client_path(booking.client.user)) unless booking.client.user.nil?
        end
        row :offer
        row :promo_code
        row :created_at
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
        row :created_at
        row :updated_at
      end
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
