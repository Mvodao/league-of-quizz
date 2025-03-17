class GamesController < ApplicationController
  def new
    @game = Game.new
    @current_user = current_user
  end

  def create
    @game = Game.create
    user_game = UserGame.new
    user_game.game = @game
    user_game.user = User.find(params[:user_1])
    user_game.spell = Spell.find(2)
    user_game.category = Category.find(2)
    user_game.save

    user_game = UserGame.new
    user_game.game = @game
    user_game.user = User.find(params[:user_2])
    user_game.spell = Spell.find(1)
    user_game.category = Category.find(1)
    user_game.save
    redirect_to edit_game_path(@game)
  end

  def start
    @game = Game.find(params[:id])
    raise
    Game.first.questions.each do |question|
      pools = QuestionsPool.new
      pools.game = @game
      pools.question = question
      pools.save
    end
    raise

    # redirect_to game_question_path(@game, 1)
  end

  def add_spell
    @game = Game.find(params[:id])
    @current_user_user_games = @game.user_games.find_by(user: current_user)
    @opponent_user_games = @game.user_games.where.not(user: current_user)[0]
    @current_user_user_games.update(spell: Spell.find(params[:spell_id]))
    @opponent_user_games.update(spell: Spell.find(2))
    redirect_to start_game_path(@game)
  end

  def edit
    @game = Game.find(params[:id])
    @spells = Spell.all
  end

  def update
    if params.key?(:question_id)
      score
    end
  end

  def score
    @game = Game.find(params[:id])
    @question_id = params[:question_index].to_i - 1
    @question = @game.questions[@question_id]
    @answer = Answer.find(params[:answer_id])
    raise
    @is_correct = @answer.is_correct
    if params[:question_index].to_i == 1
      last_score = @game.user_games.find_by(user: current_user).score
      @game.user_games.find_by(user: current_user).update(score: last_score + 1)
      @next_question = @game.questions[@question_id + 1]
      redirect_to game_question_path(@game, @next_question)
    elsif params[:question_index].to_i == 2
      last_score = @game.user_games.where.not(user: current_user)[0].score
      @game.user_games.where.not(user: current_user)[0].update(score: last_score + 1)
      @next_question = @game.questions[@question_id + 1]
      redirect_to game_question_path(@game, @next_question)
    elsif params[:question_index].to_i == 3
      last_score = @game.user_games.find_by(user: current_user).score
      @game.user_games.find_by(user: current_user).update(score: last_score + 1)
      @next_question = @game.questions[@question_id + 1]
      redirect_to game_question_path(@game, @next_question)
    elsif params[:question_index].to_i == 4 && @is_correct
      last_score = @game.user_games.where.not(user: current_user)[0].score
      @game.user_games.where.not(user: current_user)[0].update(score: last_score - 2)
      @next_question = @game.questions[@question_id + 1]
      redirect_to game_question_path(@game, @next_question)
    elsif params[:question_index].to_i == 4 && !@is_correct
      last_score = @game.user_games.find_by(user: current_user).score
      @game.user_games.find_by(user: current_user).update(score: last_score - 1)
    else
      last_score = @game.user_games.find_by(user: current_user).score
      @game.user_games.find_by(user: current_user).update(score: last_score + 1)
      @next_question = @game.questions[@question_id + 1]
      redirect_to result_game_path(@game)
    end
  end

  def result
    @game = Game.find(params[:id])
    @user1 = @game.user_games.find_by(user: current_user)
    @user2 = @game.user_games.where.not(user: current_user)[0]
  end
end
