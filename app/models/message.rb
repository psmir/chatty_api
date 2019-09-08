# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :user, inverse_of: :messages

  scope :newer, -> { order(created_at: :desc) }
  scope :latest, ->(n) { newer.limit(n) }
end
