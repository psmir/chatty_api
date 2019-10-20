# frozen_string_literal: true

class User::SayBroadcaster < BaseBroadcaster
  def execute
    return unless outcome.success?

    ActionCable.server.broadcast(
      'ChatChannel',
      message: {
        id: outcome.result[:id],
        author: actor.email,
        body: outcome.result[:body]
      }
    )
  end
end
