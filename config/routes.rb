Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Defines the root path route ("/")
  # root "posts#index"
  resources :games, only: [:new, :create, :edit, :update, :show] do
    # member do
    #   get 'show/:question_index', action: :show, as: :question
    #   post 'validate_answer'
    # end
    member do
      post "add_spell", to:"games#add_spell"
      post "add_banned_category", to:"games#add_banned_category"
      get "start", to: "games#start"
      get "result", to:"games#result"
    end
    resources :questions, only: [:show]
  end
end
