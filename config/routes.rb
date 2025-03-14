Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Defines the root path route ("/")
  # root "posts#index"
  resources :games, only: [:new, :create, :edit, :update, :show] do
    member do
      post 'select_spell'
      get 'result', to: "games#results"
    end
    resources :questions, only: [:show]
  end
  resources :leaderboards, only: [:show]
end
