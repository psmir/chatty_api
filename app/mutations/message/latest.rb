# frozen_string_literal: true

class Message::Latest < BaseMutation
  def authorized?
    actor.present?
  end

  def execute
    Message.latest(10).map do |msg|
      { id: msg.id, author: msg.user.email, body: msg.body}
    end
  end
end
