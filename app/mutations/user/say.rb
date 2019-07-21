# frozen_string_literal: true

class User::Say < BaseMutation
  required do
    string :message
  end

  def authorized?
    actor.present?
  end

  def execute
    puts "Message from #{actor.email}: #{message}"
  end
end
