require 'active_model'
require 'rspec'
require 'lib/id'
require 'support/active_model_lint'


RSpec.configure do |config|
  config.order = :rand
  config.color_enabled = true
end
