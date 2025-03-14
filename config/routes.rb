Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Defines the root path route ("/")
  # root "posts#index"
  resources :games, only: [:new, :create, :edit, :update, :show] do
    member do
      get 'show/:question_index', action: :show, as: :question
      post 'validate_answer'
      post 'select_spell'
    end
  end
  resources :leaderboards, only: [:show]
end
