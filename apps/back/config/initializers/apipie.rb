Apipie.configure do |config|
  config.app_name                = "Back"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/apipie"

  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
end

# Here we override the default "ParamInvalid" error to return a more
# humain readable error to the API.
# By default, it returns an unusable user error
# See: https://github.com/Apipie/apipie-rails/blob/cdff4ec654ee70dd222c7d75f64e20b167b44fce/lib/apipie/errors.rb#L57
class Apipie::ParamInvalid < Apipie::DefinedParamError
  attr_accessor :value, :error

  def initialize(param, value, error)
    super param
    @value = value
    @error = error
  end

  def to_s
    @error
  end
end
