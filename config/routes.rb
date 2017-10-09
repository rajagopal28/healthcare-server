Rails.application.routes.draw do
  get 'home/index'

  resources :medicine_intake_logs
  resources :doctor_notifications
  resources :user_vital_logs
  resources :in_patients
  resources :prescribed_medicines do
    get 'filtered', :on => :collection
  end
  resources :prescriptions
  resources :medicines
  resources :doctor_appointments
  resources :doctors do
    get 'login', :on => :collection
    post 'signin', :on => :collection
    get 'logout', :on => :collection
  end
  resources :users do
    get 'login', :on => :collection
    post 'signin', :on => :collection
    get 'logout', :on => :collection
  end
  get 'user_vital_summary', to: 'user_vital_summary#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => 'home#index'
end
