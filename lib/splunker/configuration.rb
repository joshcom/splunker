module Splunker
  module Configuration
    MUTABLE_OPTION_KEYS = [:endpoint, :username, :password, :app]
    # These options are mutable, but their setters are manually implemented
    MUTABLE_IMPLEMENTED_OPTION_KEYS = [:auth_mode]
    READONLY_OPTION_KEYS = [:request_handler]

    DEFAULT_ENDPOINT = "https://localhost:8089"
    DEFAULT_APP_NAME = "search"

    def self.included(base)
      base.class_eval do
        attr_accessor *MUTABLE_OPTION_KEYS
        attr_reader *MUTABLE_IMPLEMENTED_OPTION_KEYS
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

    def auth_mode=(mode)
      @request_handler = if mode.nil?
                           nil
                         else
                           Auth.create(mode, configuration)
                         end
    end
    
    def reset
      self.endpoint = DEFAULT_ENDPOINT
      self.app = DEFAULT_APP_NAME
      self.auth_mode = nil
      @username = @password = nil
    end
  end
end
