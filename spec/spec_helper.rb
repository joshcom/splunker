require 'rspec'
require 'splunker'
require 'rspec_let_definitions'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
  config.include Splunker::RspecLetDefinitions
end
