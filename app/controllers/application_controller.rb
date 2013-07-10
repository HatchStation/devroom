class ApplicationController < ActionController::Base
  protect_from_forgery
  after_filter :evaluate_user_status

  def after_sign_in_path_for(resource)
    PrivatePub.publish_to "/users/list", :list => User.user_list
    room_path
  end

  def after_sign_out_path_for(resource)
    current_user.update_attribute(:online, false)
    root_path
  end

  def evaluate_user_status
    return unless current_user
    current_user.update_attribute(:online, true) unless current_user.online?
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
