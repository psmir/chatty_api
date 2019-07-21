module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body)
    end
  end
end

RSpec.configure do |config|
  config.include Requests::JsonHelpers, type: :request # apply to all spec for apis folder
end
