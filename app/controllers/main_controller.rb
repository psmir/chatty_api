# frozen_string_literal: true

class MainController < ApplicationController
  OPERATIONS = [User::GenerateAuthToken, User::SignUp, User::Say, Message::Latest].freeze
  class OperationNotFountError < StandardError; end

  before_action :find_operation, only: :operation

  rescue_from 'OperationNotFountError' do
    render json: { error: 'Operation not found' }, status: 404
  end

  def operation
    outcome = @operation.run(operation_params, actor: current_user)

    if outcome.success?
      render json: { success: true, payload: outcome.result }
    else
      render json: { success: false, errors: outcome.errors.message }
    end
  end

  private

  def operation_params
    params[:payload] || {}
  end

  def find_operation
    @operation = OPERATIONS.find { |m| m.name == params[:name] }
    raise OperationNotFountError unless @operation.present?
  end
end
