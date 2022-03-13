json.extract! address, :id, :name, :street_name, :city, :state, :postal_code, :area_code, :country_code, :lat, :lng, :created_at, :updated_at, :region, :department
json.url address_url(address, format: :json)
