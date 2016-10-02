class UsersController < ApplicationController

  skip_before_action :login_require, only: [:index, :login]

  def index
  end

  def login
    binding.pry
    p user_params[:login_id]
    p user_params[:password]
    # IDチェック Userコレクションから存在するかどうかチェックする
    user = User.find_by(login_id: user_params[:login_id].downcase)

    # パスワードが一致するかチェックする。
    if user.password == user_params[:password]
      # 一致
      sign_in(user)
      # sessionにユーザーIDをつめる。ユーザー名等は毎回IDをもとに聞きに行く。
      # before_actionにsessionユーザIDが存在するかチェックする処理を書く。

      redirect_to contents_path
    else
      # 不一致エラー
    end
  end

  private

    def user_params
      params.require(:user).permit(:login_id, :password, :name, :is_admin, :last_updated_at)
    end

    def sign_in(user)
      @current_user = user
      session[:user_id] = user.id
      # Userコレクションを更新する処理
      ###############
      ###############
      ###############
      ###############
      ###############
      ###############
      ###############
    end
end
