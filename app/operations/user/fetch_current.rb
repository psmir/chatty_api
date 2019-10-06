# frozen_string_literal: true

class User::FetchCurrent < BaseOperation
  def authorized?
    actor.present?
  end

  def execute
    { user_id: actor.id, email: actor.email }
  end
end
