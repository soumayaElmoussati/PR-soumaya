# frozen_string_literal: true

Rails.application.routes.draw do

  apipie
  require 'sidekiq/web'
  require 'sidecloq/web'

  devise_for :admins, ActiveAdmin::Devise.config
  devise_for :users

  root to: redirect('/admin')
  resources :admins

  ActiveAdmin.routes(self)

  # Allow only admin users
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

  namespace 'api', defaults: { format: 'json' } do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {

      registrations: 'overrides/registrations',

      passwords: 'overrides/passwords',

      sessions: 'overrides/sessions',

      token_validations: 'overrides/token_validations'
    }

    devise_scope :user do
      post 'auth/google', to: 'auth#google'
      post 'auth/facebook', to: 'auth#facebook'
    end

    resources :addresses

    resources :activities do
      collection do
        get 'search'

        get 'bretagne'

        # get 'forced_activity'

      end

      member do
        post 'replace_pictures'

        post 'add_pictures'

        get 'remove_picture/:picture_id', to: 'activities#remove_picture'

      end

      resources :external_activity_bookings, only: %i[create destroy], controller: 'activity/external_activity_bookings'

      resources :activity_bookings, only: [:index], controller: 'activity/activity_bookings' do
        collection do
          post :refresh
        end
      end

    end

    resources :offers do
      collection do
        get 'search'

        get 'bretagne'

        get 'normandie'

        get 'aquitaine'

        get 'insolit'

        get 'lodge'

        get 'host'

        get 'tiny'

        get 'familly'

        get 'sitemap'

        # get 'forced_activity'

      end

      member do
        post 'replace_pictures'

        post 'replace_offer_pictures'

        post 'add_offer_pictures'

        post 'add_pictures'

        get 'remove_picture/:picture_id', to: 'offers#remove_picture'

        get 'remove_offer_picture/:picture_id', to: 'offers#remove_offer_picture'
      end

      resources :external_bookings, only: %i[create destroy], controller: 'offer/external_bookings'

      resources :bookings, only: [:index], controller: 'offer/bookings' do
        collection do
          post :refresh
          get :ical
        end
      end

      resources :periods, only: [:create, :update, :destroy], controller: 'offer/price_period'
      resources :discounts, only: [:create, :update, :destroy], controller: 'offer/price_discount'
      resources :annexe_services, only: [:create, :update, :destroy], controller: 'offer/annexe_service'
      resources :farmer_incomes, only: [:index], controller: 'offer/farmer_incomes'
    end

    resources :bookings

    resources :activity_bookings

    resources :clients do

      resources :client_bookings, path: 'bookings'

      resources :client_activity_bookings, path: 'activity_bookings'

    end

    resources :farmers do
      member do
        post 'replace_pictures'

        post 'add_pictures'

        get 'remove_picture/:picture_id', to: 'farmers#remove_picture'
      end

      resources :farmer_offers, path: 'offers'

      resources :farmer_activities, path: 'activities'

      resources :farmer_bookings, path: 'bookings'
    end

    resources :expenses do
      member do
        post 'replace_pictures'

        post 'add_pictures'

        get 'remove_picture/:picture_id', to: 'expenses#remove_picture'
      end
    end

    resources :reviews do
      member do
        post 'replace_pictures'

        post 'add_pictures'

        get 'remove_picture/:picture_id', to: 'reviews#remove_picture'
      end
    end

    resources :farmer_reviews

    namespace 'v2' do
      resources :offers

      get '/metrics', to: 'metrics#metrics'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
