# frozen_string_literal: true

require 'capybara/rspec'

# check if you have chromedriver installed
# chromedriver --version
# and install it like this if needed
# npm install chromedriver -g

Capybara.javascript_driver = :headless_chrome

Capybara.server = :puma, { Silent: true }
Capybara.server_port = 3001
# Do not forget to run this command for the client app server
# npx vue-cli-service serve --mode test --port 8081
#
Capybara.app_host = 'http://localhost:8081'

browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
  # I am getting such errors: Unable to find visible link "Login"
  # without this option
  opts.args << '--window-size=1920,1080'

  # comment it out if you want to see your specs running in the real browser
  opts.args << '--headless'
end

Capybara.register_driver :headless_chrome do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: browser_options,
    http_client: Selenium::WebDriver::Remote::Http::Default.new
  )
end
