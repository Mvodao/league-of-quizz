Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Defines the root path route ("/")
  resources :categories, only: [:index] do
    member do
      post "choose", to: "categories#choose"
    end
    end

  resources :games, only: [:new, :create, :edit, :update, :show] do
    member do
      post "add_banned_category", to: "games#add_banned_category"
      post "add_spell", to: "spells#add_spell"
      get "choose_spell", to: "spells#edit"
      get "start", to: "games#start"
      get "result", to: "games#result"
      get "result_training", to: "games#training_result"
    end
    resources :questions, only: [:show]
  end
end
