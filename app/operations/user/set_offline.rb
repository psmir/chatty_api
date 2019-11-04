# frozen_string_literal: true

class User::SetOffline < BaseOperation
  required do
    integer :user_id
  end

  def authorized?
    actor.id == user_id
  end

  def execute
    user = User.find_by(id: user_id)
    user.set_offline! if user.present?
  end
end
