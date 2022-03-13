module Overrides

  class SessionsController < DeviseTokenAuth::SessionsController
    def render_create_success
      @user = @resource
      if @user.client.nil? && @user.farmer.nil?
        Client.create(user: @user)
      end
      respond_to do |format|
        format.json { render template: "users/show", status: :ok}
      end
    end
  end
end
