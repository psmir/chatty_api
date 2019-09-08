# frozen_string_literal: true

class User::Say < BaseMutation
  required do
    string :body
  end

  def authorized?
    actor.present?
  end

  def execute
    record = actor.messages.create(body: body)
    ActionCable.server.broadcast(
      'ChatChannel',
      message: {
        id: record.id,
        author: actor.email,
        body: record.body
      }
    )

    puts "Message from #{actor.email}: #{record.body}"
  end
end
