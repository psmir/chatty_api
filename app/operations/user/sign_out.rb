# frozen_string_literal: true

class User::SignOut < BaseOperation
  def authorized?
    actor.present?
  end

  def execute
    # do something before sign out
  end
end
