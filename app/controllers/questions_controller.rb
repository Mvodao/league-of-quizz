class QuestionsController < ApplicationController
  def show
    @game = Game.find(params[:game_id])
    @questions = @game.questions
    @current_question_index = params[:id].to_i
    @user_games = @game.user_games
    @user_spell = @user_games.find_by(user: current_user).spell
    @is_used = @user_games.find_by(user: current_user).is_used
    @quickplay = false

    if @current_question_index == 1
      @user = @user_games.find_by(user: current_user).update(score: 0)
      @user = @game.user_games.find_by(user: current_user).update(score: 0)
      #si y a un 2e user faire la ligne en dessous
      if @game.user_games.count == 2
        @user_games.where.not(user: current_user)[0].update(score: 0)
      end
    end

    if @game.user_games.count == 2
      @quickplay = true
    end



    @question = @questions[@current_question_index-1]
    @answers = @question.answers

    total_questions = @questions.size
    @progress_percentage = ((@current_question_index.to_f / total_questions) * 100).round
  end
end
