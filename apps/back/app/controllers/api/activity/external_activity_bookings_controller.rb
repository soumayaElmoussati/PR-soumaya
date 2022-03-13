# frozen_string_literal: true

class Api::Activity::ExternalActivityBookingsController < ApiController
  skip_before_action :verify_authenticity_token

  before_action :set_activity

  before_action :set_external_activity_booking, only: [:destroy]

  def create
    external_activity_booking = @activity.external_activity_bookings.build(start: external_activity_booking_params[:start], end: external_activity_booking_params[:end], uid: SecureRandom.uuid, source: :manual, notes: external_activity_booking_params[:notes])

    if external_activity_booking.save

      @activity_bookings = @activity.activity_bookings.to_display

      @external_activity_bookings = @activity.external_activity_bookings

      render template: 'api/activity/activity_bookings/index'

    else

      render json: { success: false, errors: external_activity_booking.errors }, status: :unprocessable_entity

    end
  end

  def destroy
    if @external_activity_booking.destroy

      @activity_bookings = @activity.activity_bookings.to_display

      @external_activity_bookings = @activity.external_activity_bookings

      render template: 'api/activity/activity_bookings/index'

    else

      render json: { success: false, errors: external_activity_booking.errors }, status: :unprocessable_entity

    end
  end

  private

  def set_activity
    @activity = Activity.find(params[:activity_id])
  end

  def set_external_activity_booking
    @external_activity_booking = @activity.external_activity_bookings.find(params[:id])
  end

  def external_activity_booking_params
    params.require(:external_activity_booking).permit(:start, :end, :notes)
  end
end
