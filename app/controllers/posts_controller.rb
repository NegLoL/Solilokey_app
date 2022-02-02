class PostsController < ApplicationController

    def new
        @post = Post.new
        @posts = Post.all
    end

    def show
        #@post = Post.find(params[:id])
        @post = Post.find_by(id: params[:id])
    end

    def create
        @post = Post.new(post_params)
        if @post.save
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
end
