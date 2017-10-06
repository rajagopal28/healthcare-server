Rails.application.routes.draw do
  resources :medicine_intake_logs
  resources :doctor_notifications
  resources :user_vital_logs
  resources :in_patients
  resources :prescribed_medicines
  resources :prescriptions
  resources :medicines
  resources :doctor_appointments
  resources :doctors
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
