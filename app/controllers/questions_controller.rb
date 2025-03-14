class QuestionsController < ApplicationController
  def show
    @game = Game.find(params[:game_id])
    @questions = @game.questions
    @current_question_index = params[:id].to_i
    @user_games = @game.user_games

    if @current_question_index == 1
      @user_games.find_by(user: current_user).update(score: 0)
      @user_games.where.not(user: current_user)[0].update(score: 0)
    end

    # if @user_games.find_by(user: current_user).score.blank?
    #   @user_games.find_by(user: current_user).update(score: 0)
    # end
    # if @user_games.where.not(user: current_user)[0].score.blank?
    #   @user_games.where.not(user: current_user)[0].update(score: 0)
    # end

    @question = @questions[@current_question_index-1]
    @answers = @question.answers

    total_questions = @questions.size
    @progress_percentage = ((@current_question_index.to_f / total_questions) * 100).round
  end
end
