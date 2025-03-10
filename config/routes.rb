Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Defines the root path route ("/")
  # root "posts#index"
  resources :games, only: [:new, :create, :edit, :udpate, :show]
  resources :leaderboards, only: [:show]
end
