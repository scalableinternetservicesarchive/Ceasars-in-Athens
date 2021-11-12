Rails.application.routes.draw do
  resources :availabilities
  resources :reviews
  resources :bookings
  resources :services do 
    resources :reviews
  end

  root to: 'services#index'

  get '/register' => 'users#new'
  post '/users' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'

  delete "/logout" => 'sessions#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
