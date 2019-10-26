class ApplicationController < ActionController::API
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection

  private

  def current_user
    user_id = read_from_session(:user_id)
    puts "************* #{user_id} "
    return unless user_id.present?

    @current_user ||= User.find_by(id: user_id)
  end

  def store_in_session(key, value)
    cookies.signed[key] = {
      value: value,
      httponly: true
    }
  end

  def read_from_session(key)
    cookies.signed[key]
  end

  def remove_from_session(key)
    cookies.signed[key] = nil
  end
end
