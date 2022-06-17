class UsersController < ApplicationController

    #Let's a user create a login before authorizing their credentials
    skip_before_action :authorize, only: :create

    #Creates a new user
    #Error messages are handled in the application controller
    def create 
        #Raise exception with create to trigger invalid error response
        user = User.create!(user_params)
        session[:user_id] = user.id 
        render json: user, status: :created
    end

    #Finds the user by the id saved in the session hash
    def show 
        render json: @current_user
    end

    private 

    def user_params
        params.permit(:username, :password, :password_confirmation, :image_url, :bio)
    end
end
