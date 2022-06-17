class ApplicationController < ActionController::API
  include ActionController::Cookies

  rescue_from ActiveRecord::RecordInvalid, with: :invalid

  #Makes sure that a user is logged in before doing anything else
  before_action :authorize 

  private 

  #Authorize method makes sure that a user is logged in prior to performing any actions

  def authorize 
    #Use find_by here since we do not need an exception to be raised
    @current_user = User.find_by(id: session[:user_id])
    #Error message needs to be in an array for the front end to process
    render json: { errors: ["Not authorized"] }, status: :unauthorized unless @current_user
  end

  def invalid(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

end
