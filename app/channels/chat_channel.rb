# frozen_string_literal: true

class ChatChannel < ApplicationCable::Channel
  def subscribed
    User::SetOnline.run_and_broadcast({ user_id: current_user.id }, actor: current_user)
    stream_from 'ChatChannel'
  end

  def unsubscribed
    User::SetOffline.run_and_broadcast({ user_id: current_user.id }, actor: current_user)
    # Any cleanup needed when channel is unsubscribed
  end
end
