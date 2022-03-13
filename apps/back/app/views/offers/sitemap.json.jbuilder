json.offers do
  json.array! @offers, partial: 'offers/light', as: :offer
end