Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Defines the root path route ("/")
  resources :games, only: [:new, :create, :edit, :update, :show] do
    member do
      post "add_spell", to:"spells#add_spell"
      post "add_banned_category", to:"games#add_banned_category"
      get "choose_spell", to:"spells#edit"
      get "start", to: "games#start"
      get "result", to:"games#result"
    end
    resources :questions, only: [:show]
  end
end
