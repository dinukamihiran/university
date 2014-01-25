class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception 
  
  before_filter :update_sanitized_params, if: :devise_controller?
  
  $data_per_page = 10
  
def update_sanitized_params
  devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :username, :full_name, :batch, :degree, :password, :password_confirmation)}
end

def local_request?
  false
end

end
