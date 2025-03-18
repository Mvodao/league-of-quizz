class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Categories.new
  end

  def create
    @category = Categories.create
  end

  def choose
    @game = Game.create
    @user_game = UserGame.new(game: @game, user: current_user)
    category = Category.find(params[:id])
    @user_game.category = category
    @user_game.spell = Spell.first
    @user_game.save!

    redirect_to start_game_path(@game)
  end

  def add_category
    @game = Game.find(params[:id])
    @current_user_user_games = @game.user_games.find_by(user: current_user)
    @current_user_user_games.update(category: Category.find(params[:category_id]))
    redirect_to start_game_path(@game)
  end
end
