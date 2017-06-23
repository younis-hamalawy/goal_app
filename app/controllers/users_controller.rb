class UsersController < ApplicationController

  # before_action :require_same_user, only[:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # login!(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      render :new, status: 422
    end
  end

  def edit
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to user_url(user)
    else
      flash[:errors] = user.errors.full_messages
      render :edit, status: 422
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
