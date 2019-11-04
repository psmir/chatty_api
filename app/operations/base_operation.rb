# frozen_string_literal: true

class BaseOperation < Mutations::Command
  def self.descendant?(name)
    descendants.map(&:to_s).include?(name)
  end

  def self.run_and_broadcast(params, actor:, broadcaster: nil)
    broadcaster ||= infer_broadcaster
    if broadcaster.nil?
      raise NotImplementedError.new(message: 'Define or pass the broadcaster')
    end

    outcome = run(params, actor: actor)
    broadcaster.execute(params, outcome, actor)
  end

  def self.infer_broadcaster
    broadcaster_name = "#{name}Broadcaster"
    return unless BaseBroadcaster.descendant?(broadcaster_name)

    broadcaster_name.constantize
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
