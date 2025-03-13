class LeaderboardsController < ApplicationController
  def index
    @game = Game.find(params[:game_id])
    @user_games = @game.user_games
    @user1 = @user_games.find_by(user: current_user)
    @user2 = @user_games.where.not(user: current_user)[0]
  end
end
