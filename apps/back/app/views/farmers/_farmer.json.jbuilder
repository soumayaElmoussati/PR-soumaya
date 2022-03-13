json.extract! farmer, :id, :description, :agriculteur_de_bretagne, :stripe_link, :payments_authorisation
json.user do
  json.extract! farmer.user, :id, :first_name, :last_name, :created_at, :email, :cellphone, :ambassador
end
json.offers do
  json.array! farmer.offers.where(state: "published"), partial: 'offers/offer', as: :offer
end
json.activities do
  json.array! farmer.activities.where(state: "published"), partial: 'activities/activity', as: :activity
end
json.pictures do
  json.array! farmer.cloud_profile_pictures, :public_id, :url, :order
end
