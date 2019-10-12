class ApplicationController < ActionController::API
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection

  private

  def current_user
    puts "************* #{session[:user_id]} "
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
