class Api::BookingsController < ApiController
  protect_from_forgery prepend: true

  # POST /bookings
  # POST /bookings.json
  def create
    @booking = Booking.new(booking_params)
    respond_to do |format|
      if @booking.save!
        begin
          @booking.notify_slack
        rescue => e
          puts "An error occured while notifying slack: #{e}"
        end
        format.json { render template: 'bookings/show', status: :created }
      else
        format.json { render json: { errors: @booking.errors }, status: :unprocessable_entity }
      end
    end
  end

  def update
    @booking = Booking.find(params[:id])
    respond_to do |format|
      if @booking.update(booking_params)
        format.json { render template: 'bookings/show', status: :ok }
      else
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def show
    @booking = Booking.find(params[:id])

    check_payment(@booking)


    respond_to do |format|
      format.json { render template: 'bookings/show', status: :ok }
      format.pdf do
        render pdf: "file_name", template: "booking/show"   # Excluding ".pdf" extension.
      end
    end

  end

  private

    def check_payment(booking)

      if Rails.env != "production"
        api_key = 'sk_test_Rn5msomXPxHV2Y5ynnVopH3t'
      else
        api_key = 'sk_live_5yu6ZXc5hWG25fp2PXCJ7eDu004rx8VS3Q'
      end

      Stripe.api_key = api_key

      if !booking.stripe_token.nil?

        payment_state = Stripe::Checkout::Session.retrieve(
          booking.stripe_token
        )

        if payment_state.payment_status == "paid" && booking.status == "confirmed"
          pi = Stripe::PaymentIntent.retrieve(payment_state.payment_intent)
          ch = Stripe::Charge.retrieve(pi.charges.data.first.first[1])
          booking.update(status: "payed", receipt_url: ch.receipt_url)
        end

      end

    end

    def booking_params
      permitted_params = params.require(:booking).permit(
        :status,
        :client_id,
        :offer_id,
        :message,
        :contact_number,
        :people_count,
        :adult_count,
        :child_count,
        :arrival_date,
        :departure_date,
        :promo_code,
        :breakfast_opt,
        :cleaning_opt,
        :linens_opt,
        :annexe_services_total,
        :breakfast_total,
        :linens_total,
        :cleaning_total,
        :stripe_token,
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
        :receipt_url
      )

      permitted_params
    end
end
