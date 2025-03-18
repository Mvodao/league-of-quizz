class SpellsController < ApplicationController
  def edit
    @game = Game.find(params[:id])
    @spells = Spell.all
  end

  def add_spell
    @game = Game.find(params[:id])
    @current_user_user_games = @game.user_games.find_by(user: current_user)
    @opponent_user_games = @game.user_games.where.not(user: current_user)[0]
    @current_user_user_games.update(spell: Spell.find(params[:spell_id]))
    @opponent_user_games.update(spell: Spell.find(2))
    redirect_to start_game_path(@game)
  end
end
