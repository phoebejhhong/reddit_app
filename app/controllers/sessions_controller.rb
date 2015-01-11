class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(user_params)
    if @user.nil?
      flash[:errors] = "Wrong username or password"
      @user = User.new
      render :new
    elsif
      log_in!(@user)
      redirect_to subs_url
    end
  end

  def destroy
    current_user.reset_session_token
    session[:session_token] = nil
    redirect_to new_session_url
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end

end
