class GamesController < ApplicationController
  def new
  end

  def create
    @game = Game.new
    redirect_to edit_game_path(@game)
  end
  def edit
    @game = Game.find(params[:id])
    @spells = Spell.all
  end

  def update
    if !(defined? @question_id)
      @question_id = 0
    end
    if params.key?(:question_id)
      score
    end
  end

  def score
    @game = Game.find(params[:id])
    @question_id = params[:question_index].to_i - 1
    @question = @game.questions[@question_id]
    @answer = Answer.find(params[:answer_id])
    if @answer.is_correct && params[:question_index].to_i < @game.questions.count
      flash[:notice] = "Bonne réponse !"
      last_score = @game.user_games.find_by(user: current_user).score
      @game.user_games.find_by(user: current_user).update(score: last_score + 1)
      @next_question = @game.questions[@question_id + 1]
      redirect_to game_question_path(@game, @next_question)
    elsif @answer.is_correct && params[:question_index] = @game.questions.count
      redirect_to game_leaderboards_path(@game)
    else
      flash[:alert] = "Mauvaise réponse ! Essaye encore"
      last_score = @game.user_games.find_by(user: current_user).score
      @game.user_games.find_by(user: current_user).update(score: last_score - 1)
    end
  end

  def result
    @game = Game.find(params[:id])
    @user_games = @game.user_games
    @user1 = @user_games.find_by(user: current_user)
    @user2 = @user_games.where.not(user: current_user)[0]
  end
end
