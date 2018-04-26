class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def verify_admin
    if user_signed_in?
      unless current_user.try(:admin?)
        redirect_to forbidden_path
      end
    end
  end
end
