class SessionsController < ApplicationController
  before_action :forbid_login_user, {only: [:new, :create]}
  before_action :authenticate_user, {only: [:destroy]}

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      #一度しか表示されないようにバグ回避の.now
      flash.now[:danger] = "ログインに失敗しました"
      render "new"
    end
  end

  def destroy
    log_out
    redirect_to "/"
  end
end
