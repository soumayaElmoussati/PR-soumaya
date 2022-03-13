class Api::ClientsController < ApiController
  protect_from_forgery prepend: true

  # POST /clients
  # POST /clients.json
  def create
    if @user = User.find_by(email: params[:client][:user][:email])
      @user.client.user_id = User.find_by(email: params[:client][:user][:email]).id
      @client = @user.client
    else
      @client = Client.new(client_params)
    end
    respond_to do |format|
      if @client.save
        format.json { render template: 'clients/show', status: :created }
        # format.json { render :show, status: :created, location: @client }
      else
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # Never trust parameters from the scary internet, only allow the white list through.

    def client_params
      permitted_params = params.require(:client).permit(
        :user_id,
        user: [
          :first_name,
          :last_name,
          :email,
          :phone,
          :cellphone,
          :password,
          :password_confirmation,
          :birthdate
        ]
      )

      # client = params[:id].nil? ? Client.new : Client.find(params[:id])
      # user = client.user unless client.nil? || client.user.nil?

      user = User.new

      permitted_params[:user] = user

      permitted_params
    end
end
