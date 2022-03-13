class Api::ClientActivityBookingsController < ApiController
  protect_from_forgery prepend: true

  before_action :set_client, only: [:index]

  def index
    @user = current_user
    @bookings = ActivityBooking.where(client_id: @user.client.id)
    respond_to do |format|
      format.json { render template: 'activity_bookings/index', status: :ok }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:client_id])
    end

end
