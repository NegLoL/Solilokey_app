class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "ユーザー登録が正常に完了しました"
      redirect_to @user #showページへ
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])#仮
  end


  private
    #ストロングパラメータ #image_nameはattributeで初期値入れてる
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
