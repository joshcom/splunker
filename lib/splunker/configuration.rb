module Splunker
  module Configuration
    MUTABLE_OPTION_KEYS = [:endpoint, :username, :password, :app]
    READONLY_OPTION_KEYS = []

    DEFAULT_ENDPOINT = "https://localhost:8089"
    DEFAULT_APP_NAME = "search"

    def self.included(base)
      base.class_eval do
        attr_accessor *MUTABLE_OPTION_KEYS
        attr_reader *READONLY_OPTION_KEYS
      end
    end

    def configure
      yield self
    end
    
    def configuration
      MUTABLE_OPTION_KEYS.inject({}) do |conf,key|
        conf.merge!(key=>self.send(key))
      end
    end
    
    def reset
      self.endpoint = DEFAULT_ENDPOINT
      self.app = DEFAULT_APP_NAME
      @username = @password = nil
    end
  end
end
