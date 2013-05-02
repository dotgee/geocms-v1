Geocms2::Application.routes.draw do
   require 'sidekiq/web'
   mount Sidekiq::Web => '/sidekiq'
  # constraints(lambda { |r| ENV["MONO_ACCOUNT"].to_bool }) do
    # Authentication
    get "logout" => "sessions#destroy", :as => "logout"
    get "login" => "sessions#new", :as => "login"
    resources :users, :only => [:new, :create]
    resources :sessions, :only => [:new, :create, :destroy]


    # Backend
    namespace :backend do

      root :to => "categories#index"

      resources :categories do
        member do
          get "move", :to => "categories#move"
        end
        resources :layers
      end

      resources :layers, :only => [:create] do
        member do
          get "getfeatures", :to => "layers#getfeatures"
        end
      end

      resources :data_sources do
        member do
          get "import"
        end
      end

      resources :preferences, :only => [] do
        collection do
          get "edit"
          put "update"
        end
      end

      resources :users, :only => [:index, :new, :create]
      resources :contexts do
      	member do
      	  get 'refresh_preview'
      	end
      end

    end

    # Frontend
    resources :layers, :only => [:index, :show] do
      collection do
        get "search"
      end
      member do
        get "bbox"
      end
    end
    match "/categories/:category_id/layers/", :to => "categories#layers"
    resources :categories, :only => [:index, :show]
    resources :contexts

    # Explore
    match "/:id/share", :to => "contexts#share", :as => :share_context
    match "/:id", :to => "contexts#show"

    root :to => "contexts#new"
  # end

  # get "signup" => "users#new", :as => "signup"
  # resources :users, :only => [:create]
  # resources :accounts, :only => [:new, :create]
  # root :to => "home#index"

end
