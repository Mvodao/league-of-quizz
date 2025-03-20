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
    user_game.is_used = false
    user_game.save

    user_game = UserGame.new
    user_game.game = @game
    user_game.user = User.find(params[:user_2])
    user_game.spell = Spell.find(1)
    user_game.category = Category.find(1)
    user_game.is_used = false
    user_game.save
    redirect_to choose_spell_game_path(@game)
  end

  def start
    @game = Game.find(params[:id])
    if @game.questions.count < 5
      if @game.user_games.count == 2
        Game.first.questions.each do |question|
          QuestionsPool.create(game: @game, question: question)
        end
      else
        category = @game.user_games.find_by(user: current_user).category
        questions = Question.where(category: category)
        questions.sample(5).each do |question|
          QuestionsPool.create(game: @game, question: question)
        end
      end
    end
  end

  def update
    @game = Game.find(params[:id])
    if params.key?(:question_id)
      if @game.user_games.count == 2
        # quick_play_score_scripted
        quick_play_score
      else
        training_score
      end
    end
  end


  def quick_play_score
    @game = Game.find(params[:id])
    @question_id = params[:question_index].to_i - 1
    @question = @game.questions[@question_id]
    @answer = Answer.find(params[:answer_id])
    @is_correct = @answer.is_correct

    if @is_correct && @game.questions_pools.find_by(question: @question).user.blank?
      last_score = @game.user_games.find_by(user: current_user).score
      @game.user_games.find_by(user: current_user).update(score: last_score + 1)
      @next_question = params[:question_index].to_i + 1
      @game.questions_pools.find_by(question: @question).update(user: current_user)
      # broadcast a mettre en place ici
      Turbo::StreamsChannel.broadcast_append_to(
        "game-#{@game.id}",
        partial: "questions/reload",
        target: "reload-div",
        locals: {userWhoAnswered: current_user.id})
    else
      last_score = @game.user_games.find_by(user: current_user).score
      @game.user_games.find_by(user: current_user).update(score: last_score - 1)
    end
  end

  def training_score
    @game = Game.find(params[:id])
    @question_id = params[:question_index].to_i - 1
    @question = @game.questions[@question_id]
    @answer = Answer.find(params[:answer_id])
    @is_correct = @answer.is_correct
    if @is_correct
      last_score = @game.user_games.find_by(user: current_user).score
      @game.user_games.find_by(user: current_user).update(score: last_score + 1)
      @next_question = params[:question_index].to_i + 1
      # if  @next_question > @game.questions.count
      #   redirect_to result_training_game_path(@game)
      # else
      #   redirect_to game_question_path(@game, @next_question)
      # end
    else
      last_score = @game.user_games.find_by(user: current_user).score
      @game.user_games.find_by(user: current_user).update(score: last_score - 1)
    end
  end

  def quick_play_score_scripted
    @game = Game.find(params[:id])
    @game.user_games.find_by(user: current_user).update(is_used: params[:bonus_disabled])
    @question_id = params[:question_index].to_i - 1
    @question = @game.questions[@question_id]
    @answer = Answer.find(params[:answer_id])
    @is_correct = @answer.is_correct

    if params[:question_index].to_i == 2
      last_score = @game.user_games.where.not(user: current_user)[0].score
      @game.user_games.where.not(user: current_user)[0].update(score: last_score + 1)
      @next_question = params[:question_index].to_i + 1
      redirect_to game_question_path(@game, @next_question)
    elsif params[:question_index].to_i == 4
      last_score = @game.user_games.where.not(user: current_user)[0].score
      @game.user_games.where.not(user: current_user)[0].update(score: last_score - 2)
      @next_question = params[:question_index].to_i + 1
      redirect_to game_question_path(@game, @next_question)
    end

    if @is_correct && !(params[:question_index].to_i == 4 || params[:question_index].to_i == 2)
      if params[:question_index].to_i == 1
        last_score = @game.user_games.find_by(user: current_user).score
        @game.user_games.find_by(user: current_user).update(score: last_score + 1)
        @next_question = params[:question_index].to_i + 1
        redirect_to game_question_path(@game, @next_question)
      elsif params[:question_index].to_i == 3
        last_score = @game.user_games.find_by(user: current_user).score
        @game.user_games.find_by(user: current_user).update(score: last_score + 1)
        @next_question = params[:question_index].to_i + 1
        redirect_to game_question_path(@game, @next_question)
      else
        last_score = @game.user_games.find_by(user: current_user).score
        @game.user_games.find_by(user: current_user).update(score: last_score + 1)
        @next_question = params[:question_index].to_i + 1
        redirect_to result_game_path(@game)
      end
    else
      last_score = @game.user_games.find_by(user: current_user).score
      @game.user_games.find_by(user: current_user).update(score: last_score - 1)
    end
  end

  def result
    @game = Game.find(params[:id])
    @user1 = @game.user_games.find_by(user: current_user)
    @user2 = @game.user_games.where.not(user: current_user)[0]
  end

  def training_result
    @game = Game.find(params[:id])
    @current_user = @game.user_games.find_by(user: current_user)
    @questions = @game.questions
  end
end
