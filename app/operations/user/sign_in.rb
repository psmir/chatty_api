# frozen_string_literal: true

class User::SignIn < BaseOperation
  required do
    string :email
    string :password
  end

  def authorized?
    true
  end

  def execute
    user = User.find_by(email: email)
    return { user_id: user.id } if user.present? && user.authenticate(password)

    add_error(:base, :not_authenticated, 'Wrong email or password')
  end
end
