json.extract! doctor, :id, :first_name, :last_name, :city, :username, :password, :address, :primary_practice, :secondary_practice, :created_at, :updated_at, :gcmid
json.url doctor_url(doctor, format: :json)
