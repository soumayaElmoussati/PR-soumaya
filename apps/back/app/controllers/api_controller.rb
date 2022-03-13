class ApiController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken

  rescue_from Apipie::ParamInvalid do |exception|
    render status: 400, json: {
      status: 400,
      param: exception.param,
      value: exception.value,
      error: exception.to_s,
    }
  end
end
