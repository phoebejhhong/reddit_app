class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in!(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.friendly.find(params[:id])
  end

  def edit
    @user = User.friendly.find(params[:id])
  end

  def update
    @user = User.friendly.find(params[:id])
    if @user != current_user
      flash[:error] = "You can't edit other people's profiles!"
      redirect_to user_url(@user)
    elsif @user.update(user_params)
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end

end
