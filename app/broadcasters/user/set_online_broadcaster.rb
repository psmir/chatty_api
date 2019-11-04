# frozen_string_literal: true

class User::SetOnlineBroadcaster < BaseBroadcaster
  def execute
    return unless outcome.success?

    ActionCable.server.broadcast(
      'UserListChannel',
      users: User.order(:email).select(:id, :email, :online)
    )
  end
end
