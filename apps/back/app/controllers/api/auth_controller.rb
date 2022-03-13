require 'google-id-token'
require 'koala'

class Api::AuthController < DeviseTokenAuth::ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json

  def google
    validator = GoogleIDToken::Validator.new

    begin
      # Validate Google id_token
      payload = validator.check(params[:id_token], "984686106941-ncsl2vtim04akamceo5iovp8fnm4b838.apps.googleusercontent.com")
      # Fetch or create user from Google id
      @resource = User.from_google_payload(payload, params[:farmer])

      # Generate a new token for that user
      @token = @resource.create_token
      @resource.save!
      @resource.update_auth_header(@token.token, @token.client)

      # Return user informations with auth headers
      @user = @resource
      render template: 'users/show', status: :ok
    rescue GoogleIDToken::ValidationError => e
      render json: {
        error: 'Cannot sign in using Google.'
      }, status: :unauthorized
    rescue => e
      render json: {
        error: e
      }, status: :internal_error
    end
  end

  def facebook
    begin
      graph = Koala::Facebook::API.new(params[:access_token])

      payload = graph.get_object('me', {
        fields: 'id,first_name,last_name,email'
      })

      # Fetch or create user from Facebook payload
      @resource = User.from_facebook_payload(payload, params[:farmer])

      # Generate a new token for that user
      @token = @resource.create_token
      @resource.save!
      @resource.update_auth_header(@token.token, @token.client)

      # Return user informations with auth headers
      @user = @resource
      render template: 'users/show', status: :ok
    rescue => e
      render json: {
        error: e
      }, status: :unauthorized
    end
  end
end
