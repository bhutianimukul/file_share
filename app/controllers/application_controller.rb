class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  skip_before_action :verify_authenticity_token
  helper_method :logged_in_user, :is_logged_in?

  def logged_in_user
    if session[:user_id]
      @logged_in_user ||= User.find_by(id: session[:user_id])
    end
  end

  def is_logged_in?
    !!@logged_in_user.nil?
  end

  def authenticate_user
    redirect_to "/signin" unless session[:user_id]
  end
end
