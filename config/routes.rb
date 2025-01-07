Rails.application.routes.draw do
  resources :students
  get 'students/qrcode/:registration', to: 'students#qr_code'
  post 'students/add_credits', to: 'students#add_credits'
  post 'students/use_credit', to: 'students#use_credit'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "students#index"
end
