Geocms2::Application.routes.draw do

  constraints(lambda { |r| r.subdomain.present? && r.subdomain != 'www' }) do
    
    # Authentication
    get "logout" => "sessions#destroy", :as => "logout"
    get "login" => "sessions#new", :as => "login"
    get "signup" => "users#new", :as => "signup"
    resources :users
    resources :sessions

    # Layers
    match "explore" => "layers#explore"
    resources :layers, :only => [:index, :show]

    root :to => "layers#explore"

    # Backend
    namespace :backend do

      root :to => "categories#index"
      
      resources :categories do
        resources :layers
      end

      resources :data_sources do 
        member do
          get "import"
          post "import", :to => "data_sources#do_import"
        end
      end

      resources :preferences, :only => [:edit, :update] do
        collection do
          get "edit"
          put "update"
        end
      end
    end

  end
end
