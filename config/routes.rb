Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  get "home/index"
  get "users/account", to: "users#account"
  get "users/show", to: "users#show"
  get "users/show/edit", to: "users#edit"
  resources :users, only: %i[show edit update]
  root "home#index"
  get "rooms/own", to: "rooms#index"
  get "search", to: "rooms#search", as: "search_rooms"
  resources :rooms
  resources :reservations do
    collection { post "confirm" }
  end
  post "reservations/:id" => "reservations#index"
  get "reservations/index", to: "reservations#index"
end
