class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:index, :show, :edit, :update, :likes, :destroy]}
  before_action :forbid_login_user, {only: [:new, :create]}
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}

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
      redirect_to @user
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id)
  end

  def likes
    @user = User.find(params[:id])
    @likes = Like.where(user_id: @user.id)
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
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to "/"
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

    def ensure_correct_user
      if current_user.id != params[:id].to_i
        redirect_to "/posts/new"
      end
    end
end
