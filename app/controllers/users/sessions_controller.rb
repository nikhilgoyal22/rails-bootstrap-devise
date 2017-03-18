class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    email = sign_in_params[:email]
    code = sign_in_params[:password]
    existing_code = SecretCode.find_by(code: code)

    if existing_code
      user = User.find_by(email: email, secret_code: existing_code)
      if user
        sign_in(resource_name, user)
        route_name = user.role == 'admin' ? '/' : '/users/index'
        redirect_to "#{route_name}"
      else
        flash[:error] = "Invalid Username or Password"
        redirect_to '/users/sign_in'
      end
        #respond_with resource, location: after_sign_up_path_for(resource)
    else
      flash[:error] = "Invalid Username or Password"
      redirect_to '/users/sign_in'
    end
  end

  def user_index
    if user_signed_in?
      render 'users/index'
    else
      redirect_to '/users/sign_in'
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:email, :password)
    end
  end
end
