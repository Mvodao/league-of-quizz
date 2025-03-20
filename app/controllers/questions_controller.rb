class QuestionsController < ApplicationController
  def show
    @game = Game.find(params[:game_id])
    @questions = @game.questions
    @current_question_index = params[:id].to_i
    @question = @game.questions[@current_question_index - 1]
    @next_question = @current_question_index + 1
    @user_games = @game.user_games
    @user_spell = @user_games.find_by(user: current_user).spell
    @is_used = @user_games.find_by(user: current_user).is_used
    @quickplay = false
    @already_answered = !@game.questions_pools.find_by(question: @question).user.blank?
    if @current_question_index == 1
      @user = @user_games.find_by(user: current_user).update(score: 0)
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
