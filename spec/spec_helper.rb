require 'rspec'
require 'lib/id'
require 'support/active_model_lint'

require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.order = :rand
  config.color_enabled = true
end
