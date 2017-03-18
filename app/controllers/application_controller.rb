class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      redirect_to '/users/index', :alert => exception.message
    else
      redirect_to '/users/sign_in', :alert => exception.message
    end
  end
end
