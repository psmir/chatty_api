class MainController < ApplicationController
  before_action :find_query, only: :query
  before_action :find_mutation, only: :mutation

  def query
    outcome = @query.perform(operation_params, actor: current_user)
    if outcome.success?
      render json: { success: true, payload: outcome.result }
    else
      render json: { success: false, errors: outcome.errors.message }
    end
  end

  def mutation
    outcome = @mutation.run(operation_params, actor: current_user)

    if outcome.success?
      render json: { success: true, payload: outcome.result }
    else
      render json: { success: false, errors: outcome.errors.message }
    end
  end

  private

  def operation_params
    params.require(:payload).permit!
  end

  def find_query
    @query = params[:name].constantize
  end

  def find_mutation
    @mutation = params[:name].constantize
  end
end
