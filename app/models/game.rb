class Game < ApplicationRecord
  has_many :users, through: :user_games
  has_many :questions, through: :question_pools
  has_many :spells, through: :user_games
  has_many :categories, through: :user_games
  has_many :questions_pools
  has_many :user_games
end
