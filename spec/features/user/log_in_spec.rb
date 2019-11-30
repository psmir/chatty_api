# frozen_string_literal: true

require 'rails_helper'

describe 'Login' do
  let(:password) { 'password' }
  let!(:user) { create :user, password: password, password_confirmation: password }

  it 'user can log in', js: true do
    visit '/'
    click_link 'Login'
    fill_in 'email', with: user.email
    fill_in 'password', with: password
    click_button 'Log In'
    expect(page).to have_link 'Logout'
  end
end
