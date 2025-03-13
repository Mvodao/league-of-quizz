class GamesController < ApplicationController
  def new
  end

  def create
    @game = Game.new
    @game.users << User.find(1)
    @game.users << User.find(2)
    redirect_to edit_game_path(@game)
  end

  def show
  end

  def edit
    @game = Game.find(params[:id])
    @spells = Spell.all
  end

  def udpate
  end
end
