# frozen_string_literal: true

class MainController < ApplicationController
  class OperationNotFountError < StandardError; end

  before_action :find_operation, only: :operation

  rescue_from 'OperationNotFountError' do
    render json: { error: 'Operation not found' }, status: 404
  end

  def operation
    puts "$$$$$$ #{session[:user_id]}"
    outcome = @operation.run(operation_params, actor: current_user)
    after_operation_hook outcome

    if outcome.success?
      render json: { success: true, payload: outcome.result }
    else
      render json: { success: false, errors: outcome.errors.message }
    end
  end

  # we need to run a controller hook for some actions
  #
  def after_operation_hook(outcome)
    try(hook_name_for(@operation), outcome)
  end

  def hook_name_for(operation)
    "after_#{operation.to_s.underscore.gsub('/', '_')}"
  end

  def after_user_sign_in(outcome)
    return unless outcome.success?

    session[:user_id] = outcome.result[:user_id]
  end

  def after_user_sign_up(outcome)
    return unless outcome.success?

    session[:user_id] = outcome.result[:user_id]
  end

  def after_user_sign_out(outcome)
    return unless outcome.success?

    session[:user_id] = nil
  end

  private

  def operation_params
    params[:payload] || {}
  end

  def find_operation
    raise OperationNotFountError unless BaseOperation.has_descendant?(params[:name])

    @operation = params[:name].constantize
  end
end
