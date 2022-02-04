class PrivatepostsController < ApplicationController
    before_action :authenticate_user
    before_action :ensure_correct_user, {only: [:destroy, :show]}

    def new
        @privatepost = Privatepost.new
        @privateposts = Privatepost.where(user_id: current_user.id)
    end

    def show
        @privatepost = Privatepost.find_by(id: params[:id])
    end

    def create
        @privateposts = Privatepost.where(user_id: current_user.id)
        @privatepost = Privatepost.new(privatepost_params)
        if @privatepost.save && privatepost_params_image[:image_name]
            @privatepost.image_name = "#{@privatepost.id}.jpg"
            @privatepost.save
            image = privatepost_params_image[:image_name]
            File.binwrite("public/privatepost_images/#{@privatepost.image_name}", image.read)
            redirect_to "/privateposts/new"
        elsif @privatepost.save
            redirect_to "/privateposts/new"
        else
            render "privateposts/new"
        end
    end
  
    def destroy
        @privatepost = Privatepost.find_by(id: params[:id])
        @privatepost.destroy
        redirect_to "/privateposts/new"
    end


    private
        def privatepost_params
            params.require(:privatepost).permit(:content).merge(user_id: current_user.id)
        end

        def privatepost_params_image
            params.require(:privatepost).permit(:image_name)
        end

        def ensure_correct_user
            @privatepost = Privatepost.find_by(id: params[:id])
            if @privatepost.user_id != current_user.id
              redirect_to "/posts/new"
            end
        end
end
