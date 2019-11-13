# frozen_string_literal: true

class Message::Latest < BaseOperation
  optional do
    integer :page, default: 1
  end

  def authorized?
    actor.present?
  end

  def execute
    Message.newer.page(page).per(10).reverse.map do |msg|
      { id: msg.id, author: msg.user.email, body: msg.body }
    end
  end
end
