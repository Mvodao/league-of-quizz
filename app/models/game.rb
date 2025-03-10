class Game < ApplicationRecord
  has_many :user_games
  has_many :questions, through: :question_pools
end
