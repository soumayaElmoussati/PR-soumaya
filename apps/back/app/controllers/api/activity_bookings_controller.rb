class Api::ActivityBookingsController < ApiController

  protect_from_forgery prepend: true

  # POST /bookings
  # POST /bookings.json
  def create
    @activity_booking = ActivityBooking.new(activity_booking_params)
    respond_to do |format|
      if @activity_booking.save!
        begin
          @activity_booking.notify_slack
        rescue => e
          puts "An error occured while notifying slack: #{e}"
        end
        format.json { render template: 'activity_bookings/show', status: :created }
      else
        format.json { render json: { errors: @activity.errors }, status: :unprocessable_entity }
      end
    end
  end

  def update
    # @booking = Booking.find(params[:id])
    respond_to do |format|
      if @activity_booking.update(booking_params)
        format.json { render template: 'activity_bookings/show', status: :ok }
      else
        format.json { render json: @activity_booking.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @activity_booking = ActivityBooking.find(params[:id])
    @activity_booking.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

    def activity_booking_params
      permitted_params = params.require(:activity_booking).permit(
        :status,
        :client_id,
        :activity_id,
        :people_count,
        :arrival_date,
        :departure_date,
        :promo_code
      )

      permitted_params
    end

end
