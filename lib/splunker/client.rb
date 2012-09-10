require 'splunker/configuration'
require 'splunker/auth'

module Splunker
  # The Splunk API client.
  # Methods include get, post, put, and delete HTTP helpers:
  #   c.get("...")
  # See Splunker::Request for more details.
  class Client
    include Configuration

    # Creates a new Splunker client instance.
    # Options are:
    # * :username   => Required. The username to make requests on behalf of
    # * :password   => Required. The password to authenticate with
    # * :auth_mode  => Required.  The authentication method to use.  :http_auth or :token_auth.
    # * :endpoint   => ("https://localhost:8089") The host of the Splunk API
    # * :ssl_verify => (true) If false, the SSL cert fro the Splunk server will not be verified.
    # * :app        => ("search")
    def initialize(options={})
      self.reset

      (Configuration::MUTABLE_IMPLEMENTED_OPTION_KEYS + Configuration::MUTABLE_OPTION_KEYS).each do |key|
        self.send "#{key}=", options[key] if options.include?(key)
      end
    end

    def method_missing(method,*args,&block)
      if self.request_handler.respond_to?(method)
        return self.request_handler.send(method,*args,&block)
      end
      super
    end
    
    def respond_to?(method)
      self.request_handler.respond_to?(method) || super
    end
  end
end
