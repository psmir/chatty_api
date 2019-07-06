class ApplicationController < ActionController::API
  before_action :find_query, only: :query
  before_action :find_mutation, only: :mutation

  helper_method :current_user

  def query
    outcome = @query.perform(params[:query_params])
    if outcome.success?
      render json: { success: true, result: outcome.result }
    else
      render json: { success: false, errors: outcome.errors.message }
    end
  end

  def mutation
    outcome = @mutation.run(params[:mutation_params], current_user: current_user)

    if outcome.success?
      render json: { success: true, result: outcome.result }
    else
      render json: { success: false, errors: outcome.errors.message }
    end
  end

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

  def find_query
    @query = params[:name].constantize
  end

  def find_mutation
    @mutation = params[:name].constantize
  end
end
