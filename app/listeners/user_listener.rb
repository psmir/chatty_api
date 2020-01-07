# frozen_string_literal: true

class UserListener < BaseListener
  def user_say_success(result, actor)
    ActionCable.server.broadcast(
      'ChatChannel',
      message: {
        id: result[:id],
        author: actor.email,
        body: result[:body]
      }
    )
  end

  def user_set_online_success(_result, _actor)
    ActionCable.server.broadcast(
      'UserListChannel',
      users: User.order(:email).select(:id, :email, :online)
    )
  end

  def user_set_offline_success(_result, _actor)
    ActionCable.server.broadcast(
      'UserListChannel',
      users: User.order(:email).select(:id, :email, :online)
    )
  end
end
