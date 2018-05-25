Rails.application.routes.draw do
  root "static_pages#home"
  get "new", to: "users#new"
  delete "/logout", to: "sessions#destroy"
  post "/login", to: "sessions#create"
  get "/login", to: "sessions#new"
  resources :users
  namespace :admin do
    root "static_pages#home"
  end
end
