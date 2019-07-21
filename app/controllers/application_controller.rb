class ApplicationController < ActionController::API

  private

  def current_user
    get_user_from_jwt if @current_user.nil?
    @current_user
  end

  def get_user_from_jwt
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      decoded = JsonWebToken.decode(header)
      @current_user = User.find(decoded[:user_id]) if decoded.present?
    rescue ActiveRecord::RecordNotFound => e
      Rails.logger.info e.message
    rescue JWT::DecodeError => e
      Rails.logger.info e.message
    end
  end
end
