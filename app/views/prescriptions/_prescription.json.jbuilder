json.extract! prescription, :id, :user_id, :doctor_id, :notes, :prescribed_on, :valid_till, :created_at, :updated_at
json.url prescription_url(prescription, format: :json)
