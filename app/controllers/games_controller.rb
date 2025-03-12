class GamesController < ApplicationController
  def new
  end

  def create
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
