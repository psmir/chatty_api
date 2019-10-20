# frozen_string_literal: true

class User::Say < BaseOperation
  required do
    string :body
  end

  def authorized?
    actor.present?
  end

  def execute
    record = actor.messages.create(body: body)

    { id: record.id, body: record.body }
  end
end
