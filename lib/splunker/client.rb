require 'splunker/configuration'
require 'splunker/connection'
require 'splunker/auth'
require 'splunker/request'

module Splunker
  class Client
    include Configuration

    def initialize(options={})
      self.reset
      Configuration::MUTABLE_OPTION_KEYS.each do |key|
        self.send "#{key}=", options[key] if options.include?(key)
      end
    end

    # A client has a session
    # A client makes requests
  end
end
