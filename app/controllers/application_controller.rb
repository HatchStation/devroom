class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    update_user_list(true)
    room_path
  end

  def after_sign_out_path_for(resource)
    update_user_list(false)
    root_path
  end
  
  # This action updates the status of current user and then broadcasts user list to everyone
  def update_user_list(status)
    current_user.update_attribute(:online, status)
    PrivatePub.publish_to "/users/list", :users => User.user_list
  end

  protected
 
  def devise_parameter_sanitizer
    if resource_class == User
      User::ParameterSanitizer.new(User, :user, params)
    else
      super
    end
  end

  
end
