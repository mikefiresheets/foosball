class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :require_login

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  private

    # Confirms a logged-in user for access.
    def require_login
      unless logged_in?
        store_location
        flash[:alert] = "You must log in to visit this page."
        redirect_to login_url
      end
    end
end
