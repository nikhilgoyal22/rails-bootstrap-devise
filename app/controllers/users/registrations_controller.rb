class Users::RegistrationsController < Devise::RegistrationsController
before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]
before_filter :resource_name

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end


  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    email = sign_up_params[:email]
    code = sign_up_params[:password]
    existing_code = SecretCode.find_by(code: code)
    hash = sign_up_params.except!(:password)

    if existing_code
      user = User.find_by(email: email, secret_code: existing_code)
      if user
        flash[:error] = 'User Already exists'
        redirect_to '/users/sign_up'
      else
        user = User.new(hash.merge(role: 'user', secret_code: existing_code))
        result = user.save
        if result
          flash[:notice] = 'User Signup Successfull'
          redirect_to '/users/sign_in'
        else
          flash[:error] = "Something Went Wrong"
          redirect_to '/users/sign_up'
        end
        #respond_with resource, location: after_sign_up_path_for(resource)
      end
    else
      flash[:error] = "Invalid Password"
      redirect_to '/users/sign_up'
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first, :last, :email, :password])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
