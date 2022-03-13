json.extract! expense, :id, :state, :offer_id, :expense_date, :total_ht, :total_ttc, :comment, :responsable
json.pictures do
  json.array! expense.cloud_expense_pictures, :public_id, :url, :order
end