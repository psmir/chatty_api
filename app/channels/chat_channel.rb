# frozen_string_literal: true

class ChatChannel < ApplicationCable::Channel
  def subscribed
    User::SetOnline.run!({ user_id: current_user.id }, actor: current_user)
    stream_from 'ChatChannel'
  end

  def unsubscribed
    User::SetOffline.run!({ user_id: current_user.id }, actor: current_user)
    # Any cleanup needed when channel is unsubscribed
  end
end
