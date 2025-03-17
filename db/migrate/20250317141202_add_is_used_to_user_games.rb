class AddIsUsedToUserGames < ActiveRecord::Migration[7.1]
  def change
    add_column :user_games, :is_used, :boolean
  end
end
