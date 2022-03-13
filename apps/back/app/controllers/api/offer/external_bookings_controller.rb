# frozen_string_literal: true

class Api::Offer::ExternalBookingsController < ApiController
  skip_before_action :verify_authenticity_token

  before_action :set_offer

  before_action :set_external_booking, only: [:destroy]

  def create
    external_booking = @offer.external_bookings.build(start: external_booking_params[:start], end: external_booking_params[:end], uid: SecureRandom.uuid, source: :manual, notes: external_booking_params[:notes])

    if external_booking.save

      @bookings = @offer.bookings.to_display

      @external_bookings = @offer.external_bookings

      render template: 'api/offer/bookings/index'

    else

      render json: { success: false, errors: external_booking.errors }, status: :unprocessable_entity

    end
  end

  def destroy
    if @external_booking.destroy

      @bookings = @offer.bookings.to_display

      @external_bookings = @offer.external_bookings

      render template: 'api/offer/bookings/index'

    else

      render json: { success: false, errors: external_booking.errors }, status: :unprocessable_entity

    end
  end

  private

  def set_offer
    @offer = Offer.find(params[:offer_id])
  end

  def set_external_booking
    @external_booking = @offer.external_bookings.find(params[:id])
  end

  def external_booking_params
    params.require(:external_booking).permit(:start, :end, :notes)
  end
end
