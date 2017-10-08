json.extract! doctor_notification, :id, :title, :user, :doctor, :notified_on, :notes, :severity, :created_at, :updated_at
json.url doctor_notification_url(doctor_notification, format: :json)
