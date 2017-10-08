json.extract! user_vital_log, :id, :user, :logged_on, :notes, :pressure, :sugar, :temperature, :pulse, :created_at, :updated_at
json.url user_vital_log_url(user_vital_log, format: :json)
