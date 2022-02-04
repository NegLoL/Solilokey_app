class PostsController < ApplicationController
    before_action :authenticate_user
    before_action :ensure_correct_user, {only: [:destroy]}

    def new
        @post = Post.new
        @posts = Post.all
    end

    def show
        @post = Post.find_by(id: params[:id])
    end

    def search
        if params[:keyword].present?
            @users = User.where("name like ?", "%#{params[:keyword]}%")
            @posts = Post.search(params[:keyword])
        else
            @users = User.none
            @posts = Post.none
        end
    end

    def create
        @post = Post.new(post_params)
        @posts = Post.all
        if @post.save && post_params_image[:image_name]
            @post.image_name = "#{@post.id}.jpg"
            @post.save
            image = post_params_image[:image_name]
            File.binwrite("public/post_images/#{@post.image_name}", image.read)
            redirect_to "/posts/new"
        elsif @post.save
            redirect_to "/posts/new"
        else
            render "posts/new"
        end
    end
  
    def destroy
        @post = Post.find_by(id: params[:id])
        @post.destroy
        redirect_to "/posts/new"
    end


    private
        def post_params
            params.require(:post).permit(:content).merge(user_id: current_user.id)
        end

        def post_params_image
            params.require(:post).permit(:image_name)
        end

        def ensure_correct_user
            @post = Post.find_by(id: params[:id])
            if @post.user_id != current_user.id
              redirect_to "/posts/new"
            end
        end
end
