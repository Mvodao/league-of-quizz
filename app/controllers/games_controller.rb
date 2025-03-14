class GamesController < ApplicationController
  def new
    @game = Game.new
    Question.all.sample(5).each do |question|
      question_pool = QuestionsPool.new
      question_pool.game = @game
      question_pool.question = question
      question_pool.save
    end

    puts "Données créées avec succès !"

    user_game = UserGame.new
    user_game.game = @game
    user_game.user = User.first
    user_game.spell = Spell.first
    user_game.category = Category.first
    user_game.save

    user_game = UserGame.new
    user_game.game = @game
    user_game.user = User.second
    user_game.spell = Spell.second
    user_game.category = Category.second
    user_game.save
  end

  def create

    redirect_to edit_game_path(@game)
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
