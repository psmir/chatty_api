# frozen_string_literal: true

module FeatureMacros
  module Session
    def sign_in(user)
      visit '/'
      click_link 'Login'
      fill_in 'email', with: user.email
      fill_in 'password', with: user.password
      click_button 'Log In'
      expect(page).to have_link 'Logout'
    end
  end
end

RSpec.configure do |config|
  config.include FeatureMacros::Session, type: :feature
end
