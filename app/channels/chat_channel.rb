class ChatChannel < ApplicationCable::Channel
  def subscribed
    current_user.set_online!
    broadcast_users
    stream_from 'ChatChannel'
  end

  def unsubscribed
    current_user.set_offline!
    broadcast_users
    # Any cleanup needed when channel is unsubscribed
  end

  def broadcast_users
    ActionCable.server.broadcast(
      'UserListChannel',
      users: User.order(:email).select(:id, :email, :online)
    )
  end
end
