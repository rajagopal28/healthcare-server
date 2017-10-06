json.extract! user_vital_log, :id, :user_id, :logged_on, :notes, :vital_name, :created_at, :updated_at
json.url user_vital_log_url(user_vital_log, format: :json)
