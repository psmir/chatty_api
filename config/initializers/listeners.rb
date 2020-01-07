# frozen_string_literal: true

Dir[Rails.root.join('app', 'listeners', '**', '*.rb')].each { |f| require f }

BaseListener.descendants.each do |klass|
  Wisper.subscribe klass.new
end
