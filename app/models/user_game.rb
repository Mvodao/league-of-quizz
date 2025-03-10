class UserGame < ApplicationRecord
  belongs_to :user
  belongs_to :game
  belongs_to :spell
  belongs_to :category
end
