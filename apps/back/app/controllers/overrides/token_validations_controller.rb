module Overrides
  class TokenValidationsController < DeviseTokenAuth::TokenValidationsController

    def render_validate_token_success
      @user = @resource
      request.format = :json
      respond_to do |format|
        format.json { render template: "users/show", status: :ok}
      end
    end
  end
end
