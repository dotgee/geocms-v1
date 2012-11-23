Geocms2::Application.routes.draw do


  constraints(lambda { |r| r.subdomain.present? && r.subdomain != 'www' }) do

    # Authentication
    get "logout" => "sessions#destroy", :as => "logout"
    get "login" => "sessions#new", :as => "login"
    get "signup" => "users#new", :as => "signup"
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
    resources :layers, :only => [:index, :show]
    match "/categories/:category_id/layers/", :to => "categories#layers"
    resources :categories, :only => [:index, :show]
    resources :contexts

    # Explore
    match "/:id/share", :to => "contexts#share"
    match "/:id", :to => "contexts#show"

    root :to => "contexts#new"
  end

  root :to => "home#index"
  resources :accounts, :only => [:new, :create]

end
