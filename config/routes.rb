Geocms2::Application.routes.draw do
  

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  resources :users
  resources :sessions

  match "explore" => "layers#explore"
  resources :layers, :only => [:index, :show]
  root :to => "layers#explore"

  namespace :backend do
    root :to => "layers#index"
    resources :layers
    resources :categories
    resources :data_sources
  end
end
