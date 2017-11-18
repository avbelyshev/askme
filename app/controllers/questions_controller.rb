class QuestionsController < ApplicationController
  before_action :load_question, only: [:edit, :update, :destroy]
  before_action :authorize_user, except: [:create]
  before_action :check_recaptcha, only: [:create]

  def index
    @questions = Question.all
  end

  def edit
  end

  def create
    @question = Question.new(question_params)
    @question.author_id = current_user.id if current_user.present?

    if @question.save
      redirect_to user_path(@question.user), notice: 'Вопрос задан'
    else
      render :edit
    end
  end

  def update
    if @question.update(question_params)
      redirect_to user_path(@question.user), notice: 'Вопрос сохранен'
    else
      render :edit
    end
  end

  def destroy
    user = @question.user

    @question.destroy

    redirect_to user_path(user), notice: 'Вопрос удален :('
  end

  private

  def authorize_user
    reject_user unless @question.user == current_user
  end

  def load_question
    @question = Question.find(params[:id])
  end

  def check_recaptcha
    unless current_user.present? && verify_recaptcha
      redirect_to user_path(@question.user), notice: 'Вы наверное бот!'
    end
  end

  def question_params
    if current_user.present? &&
       params[:question][:user_id].to_i == current_user.id
      params.require(:question).permit(:user_id, :text, :answer, :author_id)
    else
      params.require(:question).permit(:user_id, :text)
    end
  end
end
