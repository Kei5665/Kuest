Rails.application.routes.draw do
  root 'areas#index'

  post "oauth/callback", to: "oauths#callback"
  get "oauth/callback", to: "oauths#callback"
  get "oauth/:provider", to: "oauths#oauth", as: :auth_at_provider
  post '/guest_login', to: 'user_sessions#guest_login'
  get 'log_out', to: 'user_sessions#destroy', as: 'log_out'

  resources :home, only: %i[index]

  namespace :admin do 
    resources :posts do
      collection do
        delete :destroy_all
      end
    end
    resources :scrapes, only: %i[create]
    resources :emblems, only: %i[index create new destroy]
    resources :areas, only: %i[index create new destroy]
  end
  resources :quests do
    member do
      get :clear
    end
  end
  resources :posts
  resources :users, only: %i[edit update]
  resources :areas
end
