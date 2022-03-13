json.extract! user, :id, :first_name, :last_name, :email

if !user.farmer.nil?
  json.farmer do
    json.extract! user.farmer, :id, :payments_authorisation
    json.farmerpictures do
      json.array! user.farmer.cloud_profile_pictures, :public_id, :url, :order
    end
  end
end

if !user.client.nil?
  json.client do
    json.extract! user.client, :id
  end
end
