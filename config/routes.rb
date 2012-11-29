Geocms2::Application.routes.draw do

  constraints(lambda { |r| r.subdomain.present? && r.subdomain != 'www'  || ENV["MONO_ACCOUNT"].to_bool }) do
    # Authentication
    get "logout" => "sessions#destroy", :as => "logout"
    get "login" => "sessions#new", :as => "login"
    resources :users
    resources :sessions


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

      resources :preferences, :only => [] do
        collection do
          get "edit"
          put "update"
        end
      end

      resources :users
      resources :contexts

    end

    # Layers
    resources :layers, :only => [:index, :show] do
      collection do
        get "search"
      end
    end
    match "/categories/:category_id/layers/", :to => "categories#layers"
    resources :categories, :only => [:index, :show]
    resources :contexts

    # Explore
    match "/:id/share", :to => "contexts#share"
    match "/:id", :to => "contexts#show"

    root :to => "contexts#new"
  end

  get "signup" => "users#new", :as => "signup"
  resources :users, :only => [:create]
  resources :accounts, :only => [:new, :create]
  root :to => "home#index"

end
