class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def authenticate_active_admin!
    authenticate_user!
    if current_user && current_user.admin.nil?
      flash[:alert] = 'Unauthorized Access!'
      redirect_to new_user_session_path
    end
  end
end
