json.extract! user, :id, :first_name, :last_name, :city, :username, :password, :address, :created_at, :updated_at, :gcmid
json.url user_url(user, format: :json)
