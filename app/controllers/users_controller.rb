class UsersController < ApplicationController
  before_action :load_user, except: [:index, :create, :new]
  before_action :authorize_user, except: [:index, :new, :create, :show]

  def index
    @users = User.all
  end

  def new
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: 'Пользователь успешно зарегестрирован!'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Данные обновлены'
    else
      render 'edit'
    end
  end

  def show
    @questions = @user.questions.order(created_at: :desc)

    @new_question = @user.questions.build

    @questions_count = @questions.count
    @answers_count = @questions.where.not(answer: nil).count
    @unanswered_count = @questions_count - @answers_count

    @header_background = (@user.header_background.nil? ? "#005a55" : @user.header_background)
  end

  def destroy
    session[:user_id] = nil

    @questions_by_author = Question.where(author_id: @user.id)
    @questions_by_author.each do |q|
      q.author_id = nil
      q.save
    end

    @user.destroy
    @user = nil
    redirect_to root_url, notice: 'Пользователь успешно удален!'
  end
end

private

def authorize_user
  reject_user unless @user == current_user
end

def load_user
  @user ||= User.find params[:id]
end

def user_params
  params.require(:user).permit(:email, :password, :password_confirmation,
                               :name, :username, :avatar_url, :header_background)
end
