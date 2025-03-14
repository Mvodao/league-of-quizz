class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
    @questions = @game.questions_pools.includes(:question).map(&:question)
    @current_question_index = params[:question_index].to_i || 0

    if @current_question_index >= @questions.size
      flash[:notice] = "Toutes les questions ont été répondues !"
      @question = nil
      @answers = []
      @progress_percentage = 100
      return
    end

    @question = @questions[@current_question_index]
    @answers = @question.answers

    total_questions = @questions.size
    @progress_percentage = ((@current_question_index.to_f / total_questions) * 100).round
  end

  def validate_answer
    @game = Game.find(params[:id])
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:answer_id])

    if @answer.is_correct
      flash[:notice] = "Bonne réponse !"
    else
      flash[:alert] = "Mauvaise réponse, essaye encore"
    end

    next_question_index = params[:question_index].to_i + 1
    redirect_to question_game_path(@game, question_index: next_question_index)
  end

  def new
    @game = Game.create
  end


  def create
    @game = Game.new
    @game.users << User.find(1)
    @game.users << User.find(2)

    if @game.save
      redirect_to edit_game_path(@game)
    else
      flash[:alert] = "Une erreur s'est produite lors de la création du jeu."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @game = Game.find(params[:id])
    @spells = Spell.all
    @question = @game.questions[0]
  end

  def udpate
  end

  def select_spell
    @game = Game.find(params[:game_id])
    @spell = Spell.find(params[:spell_id])
  end


  def start
    @game = Game.find(params[:id])
    if @game.spell.nil?
      redirect_to edit_game_path(@game), alert: "Veuillez sélectionner un spell avant de lancer la partie."
    end
  end

end
