# frozen_string_literal: true

class BaseOperation < Mutations::Command
  extend Wisper::Publisher

  def self.descendant?(name)
    descendants.map(&:to_s).include?(name)
  end

  def self.run!(params, actor: nil)
    outcome = run(params, actor: actor)

    if outcome.success?
      publish(success_event_name.to_sym, outcome.result, actor)
    else
      publish(failure_event_name.to_sym, outcome.errors.message, actor)
    end

    outcome
  end

  def self.base_event_name
    to_s.underscore.gsub('/', '_')
  end

  def self.success_event_name
    base_event_name + '_success'
  end

  def self.failure_event_name
    base_event_name + '_failure'
  end

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
