class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:notice] = "ユーザー登録が正常に完了しました"
      redirect_to @user #showページへ
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if user_params_image[:image_name]
      @user.image_name = "#{@user.id}.jpg"
      image = user_params_image[:image_name]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end

    if @user.update(user_params)
      flash[:notice] = "ユーザー情報が変更されました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
  end


  private
    #ストロングパラメータ #image_nameはattributeで初期値入れてる
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

    #user画像受け取り用　
    def user_params_image
      params.require(:user).permit(:image_name)
    end
end
