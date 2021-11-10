Rails.application.routes.draw do
  resources :availabilities
  resources :reviews
  resources :bookings
  resources :services

  root to: 'services#index'

  delete "/logout" => 'sessions#destroy'

  post 'login', to: 'authentication#authenticate'
  post 'register', to: 'users#create'
  get 'checkuser', to: 'authentication#get_user'

end
