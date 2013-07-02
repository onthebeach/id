require 'rspec'
require_relative '../lib/id'
require_relative 'support/active_model_lint'


RSpec.configure do |config|
  config.order = :rand
  config.color_enabled = true
end
