json.offers do
  json.array! @offers, partial: 'offers/light', as: :offer
end
json.all_offers do
  json.array! @all_offers, partial: 'offers/light', as: :offer
end
json.meta do
  json.extract! @offers, :total_pages, :current_page, :next_page, :total_count
  json.count @count
end