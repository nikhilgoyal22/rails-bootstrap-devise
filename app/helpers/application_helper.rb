module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    #@request.env["devise.mapping"] = Devise.mappings[:user]
    @devise_mapping ||= Devise.mappings[:user]
  end
end
