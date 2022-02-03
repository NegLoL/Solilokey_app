class LikesController < ApplicationController
    before_action :set_params

    def create
        Like.create(user_id: current_user.id, post_id: params[:id])
        redirect_to "/posts/#{@post.id}"
    end

    def destroy
        Like.find_by(user_id: current_user.id, post_id: params[:id]).destroy
        redirect_to "/posts/#{@post.id}"
    end

    private
        def set_params
            @post = Post.find(params[:id])
        end

end