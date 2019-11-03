# frozen_string_literal: true

class User::List < BaseOperation
  def authorized?
    actor.present?
  end

  def execute
    User.order(:email).select(:id, :email, :online)
  end
end
