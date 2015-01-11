class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    user = User.find_by(session_token: session[:session_token])
    user ? user : nil
  end

  def logged_in?
    current_user ? true : false
  end

  def log_in!(user)
    user.reset_session_token
    session[:session_token] = user.session_token
  end

  def require_login
    unless logged_in?
      flash[:errors] = "You need to sign in first"
      redirect_to new_session_url
    end
  end
end
