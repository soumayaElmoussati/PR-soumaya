json.activities do
  json.array! @activities, partial: 'activities/activity', as: :activity
end
json.meta do
  json.extract! @activities, :total_pages, :current_page, :next_page, :total_count
  json.count @count
end
