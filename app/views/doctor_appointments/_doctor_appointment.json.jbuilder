json.extract! doctor_appointment, :id, :description, :from, :to, :doctor, :user, :created_at, :updated_at
json.url doctor_appointment_url(doctor_appointment, format: :json)
