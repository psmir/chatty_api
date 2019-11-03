class UserListChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'UserListChannel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
