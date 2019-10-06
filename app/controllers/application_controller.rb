class ApplicationController < ActionController::API
  include ActionController::Cookies
  include ActionController::RequestForgeryProtection

  private

  def current_user
    puts "************* #{session[:user_id]} "
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # def get_user_from_jwt
  #   header = request.headers['Authorization']
  #   header = header.split(' ').last if header
  #   begin
  #     decoded = JsonWebToken.decode(header)
  #     @current_user = User.find(decoded[:user_id]) if decoded.present?
  #   rescue ActiveRecord::RecordNotFound => e
  #     Rails.logger.info e.message
  #   rescue JWT::DecodeError => e
  #     Rails.logger.info e.message
  #   end
  # end
end
