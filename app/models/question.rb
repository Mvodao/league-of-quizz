class Question < ApplicationRecord
  belongs_to :category
  has_many :answers
  has_many :questions_pools
  has_many :games, through: :questions_pools
end
