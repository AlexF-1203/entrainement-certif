Rails.application.routes.draw do
  # get 'locations/index'
  # get 'locations/show'
  # get 'locations/create'
  get 'locations/edit'
  devise_for :users
  root to: "pages#home"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  # Example resource route within a namespace:
  get 'locations/map', to: 'locations#map', as: :locations_map
  resources :locations

  get "up" => "rails/health#show", as: :rails_health_check
  # Defines the root path route ("/")
  # root "posts#index"
end
