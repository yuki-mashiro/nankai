class UsersController < ApplicationController

  skip_before_action :login_require, only: [:index, :login]
  before_action :validate_login, only: [:login]

  def index
  end

  # TODO MongoDB login_idにユニークキーを付与
  def login
    reset_session

    sign_in(@user)
    redirect_to contents_path
  end

  def logout
    reset_session
    redirect_to '/users'
  end

  private

    def user_params
      params.require(:user).permit(:login_id, :password, :name, :is_admin, :last_updated_at)
    end

    def sign_in(user)
      @current_user = user
      session[:user_id] = user.id
      # Userコレクションを更新する処理
    end

    def validate_login
      begin
        @user = User.where(login_id: user_params[:login_id].downcase).first || User.new

        @user.errors.add(:login_id) if user_params[:login_id].blank?
        @user.errors.add(:password) if user_params[:password].blank?

        render :index and return if @user.errors.present?

        @user.errors.add(:login_id, 'が不正です') if @user._id.blank?
        @user.errors.add(:password, 'が不正です') unless @user.password == user_params[:password]

        render :index and return if @user.errors.present?
      rescue
        render :index and return
      end
    end
end
