# frozen_string_literal: true

class User::SignUp < BaseOperation
  required do
    string :email
    string :password
    string :password_confirmation
  end

  def authorized?
    true
  end

  def validation
    add_error(:email, :not_unique, 'Is already taken') if User.find_by(email: email).present?
    add_error(:password_confirmation, :not_equal, 'Must be equal to Password') unless password == password_confirmation
  end

  def execute
    user = User.new(email: email, password: password)
    add_error(:base, :something_wrong, 'Something went wrong') && return unless user.save

    { user_id: user.id }
  end
end
