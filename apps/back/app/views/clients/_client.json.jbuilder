json.extract! client, :id
json.user do
  json.extract! client.user, :id, :first_name, :last_name
end