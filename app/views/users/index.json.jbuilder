json.array!(@users) do |user|
  json.extract! user, :id, :first, :last, :email
  json.url user_url(user, format: :json)
end
