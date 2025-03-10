class UserGame < ApplicationRecord
  belongs_to :user
  belongs_to :game
  belongs_to :spell
  belongs_to :banned_category, class_name: "Category", foreign_key: :"banned_category_id", required: true
end
