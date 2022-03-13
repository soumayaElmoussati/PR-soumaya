class Api::Activity::ActivityBookingsController < ApiController

  skip_before_action :verify_authenticity_token, only: [:refresh]

  before_action :set_bookings, only: [:index]
  before_action :set_activity, only: [:refresh]

  def index
  end

  def refresh
    @activity.fetch_external_bookings

    @activity.reload

    @bookings = @activity.activity_bookings.to_display
    @external_activity_bookings = @activity.external_activity_bookings

    render template: 'api/activity/activity_bookings/index'
  end


  private

  def set_activity
    @activity = Activity.find(params[:activity_id])
  end

  def set_bookings
    activity = Activity.includes(:activity_bookings, :external_activity_bookings).find(params[:activity_id])

    @activity_bookings = activity.activity_bookings.to_display
    @external_activity_bookings = activity.external_activity_bookings
  end
end
