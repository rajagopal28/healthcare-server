json.extract! medicine_intake_log, :id, :prescribed_medicine, :user, :logged_on, :notes, :part_of_day, :created_at, :updated_at
json.url medicine_intake_log_url(medicine_intake_log, format: :json)
