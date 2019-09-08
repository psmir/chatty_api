# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  enum role: %i[user admin]

  has_many :messages, inverse_of: :user
end
