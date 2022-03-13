json.offers do
  json.array! @offers, partial: 'offers/light', as: :offer
end
json.meta do
  json.extract! @offers, :total_pages, :current_page, :next_page, :total_count
  if @count.present?
    json.count @count
  end
end
