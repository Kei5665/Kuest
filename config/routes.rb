Rails.application.routes.draw do
  root 'posts#index'

  post "oauth/callback", to: "oauths#callback"
  get "oauth/callback", to: "oauths#callback"
  get "oauth/:provider", to: "oauths#oauth", as: :auth_at_provider
  get 'log_out', to: 'user_sessions#destroy', as: 'log_out'

  namespace :admin do 
    resources :posts, only: %i[index create destroy]
  end
  resources :posts, only: %i[index create show destroy]
  resources :quests do
    member do
      get :clear
    end
  end
  resources :users, only: %i[edit update]
end
