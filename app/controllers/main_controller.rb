# frozen_string_literal: true

class MainController < ApplicationController
  QUERIES = [].freeze
  MUTATIONS = [User::GenerateAuthToken, User::SignUp, User::Say].freeze
  class OperationNotFountError < StandardError; end

  before_action :find_query, only: :query
  before_action :find_mutation, only: :mutation

  rescue_from 'OperationNotFountError' do
    render json: { error: 'Operation not found' }, status: 404
  end

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
    @query = QUERIES.find { |q| q.name == params[:name] }
    raise OperationNotFountError unless @query.present?
  end

  def find_mutation
    @mutation = MUTATIONS.find { |m| m.name == params[:name] }
    raise OperationNotFountError unless @mutation.present?
  end
end
