# frozen_string_literal: true

class BaseOperation < Mutations::Command
  def self.has_descendant?(name)
    descendants.map(&:to_s).include?(name)
  end

  optional do
    model :actor, class: User
  end

  def self.descendantsf
    ObjectSpace.each_object(Class).select { |klass| klass < self }
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
