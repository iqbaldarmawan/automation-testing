require 'rspec'
require 'yaml-lint'
require 'yaml'
require 'capybara/rspec'

RSpec.configure do |config|
  config.failure_color = :magenta
  config.color = true
end
