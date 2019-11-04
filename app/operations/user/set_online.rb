# frozen_string_literal: true

class User::SetOnline < BaseOperation
  required do
    integer :user_id
  end

  def authorized?
    actor.id == user_id
  end

  def execute
    user = User.find_by(id: user_id)
    user.set_online! if user.present?
  end
end
