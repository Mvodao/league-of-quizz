class Game < ApplicationRecord
  has_many :user_games
  has_many :questions_pools
  has_many :questions, through: :questions_pools
end
