class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
  	if current_user.is_guest?
  		render 'errors/account_setup'
  	else
  		if current_user.is_field_staff?
        redirect_to events_path
      else
        redirect_to main_app.root_url, alert: exception.message
      end 
  	end
  end

end
