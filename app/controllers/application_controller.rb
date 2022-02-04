class ApplicationController < ActionController::Base
    include SessionsHelper

    def authenticate_user
        if current_user == nil
          redirect_to "/login"
        end
    end
      
    def forbid_login_user
        if current_user
          redirect_to "/posts/new"
        end
    end
end
