# frozen_string_literal: true

class BaseBroadcaster
  def self.descendant?(name)
    descendants.map(&:to_s).include?(name)
  end

  def self.execute(*args)
    new(*args).execute
  end

  attr_reader :params, :outcome, :actor

  def initialize(params, outcome, actor)
    @params  = params
    @outcome = outcome
    @actor   = actor
  end

  def execute; end
end
