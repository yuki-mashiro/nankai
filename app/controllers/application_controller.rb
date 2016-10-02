class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :login_require

  helper_method :current_user

  def current_user
    @current_user
  end

  private

  def sign_in(user)
    @current_user = user
    session[:user_id] = user.id
  end

  def login_require
    if session[:user_id].blank?
      redirect_to users_path and return
    end
    sign_in(
      User.find_by(_id: session[:user_id])
    )
  end
end
