# frozen_string_literal: true

class User::GenerateAuthToken < BaseMutation
  required do
    string :email
    string :password
  end

  def authorized?
    true
  end

  def execute
    user = User.find_by(email: email)
    if user.present? && user.authenticate(password)
      return { token: JsonWebToken.encode(user_id: user.id) }
    else
      add_error(:base, :not_authenticated, 'Wrong email or password')
    end
  end
end
