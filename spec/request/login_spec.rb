# frozen_string_literal: true

require 'rails_helper'

describe 'Login', type: :request do
  let!(:user) { create :user }

  before do
    post '/operation/', params: {
      name: 'User::SignIn',
      payload: {
        email: user.email,
        password: user.password
      }
    }
  end

  it 'returns the token' do
    expect(json['success']).to be_truthy
    expect(json['payload']['user_id']).to be_present
  end
end
