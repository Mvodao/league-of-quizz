class QuestionsPool < ApplicationRecord
  belongs_to :question
  belongs_to :game
  belongs_to :user, optional: true
end
