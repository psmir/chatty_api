# frozen_string_literal: true

class BaseQuery < Mutations::Command
  optional do
    model :actor, class: User
  end

  def validate
    add_error(:base, :not_authorized, 'You are not authorized') and return unless authorized?
    validation
  end

  def authorized?
    false
  end

  def validation; end
end
