require 'faraday'
require 'splunker/faraday_middleware'

module Splunker
  module Connection
    def reset
      @connection = nil
    end

    # Returns an existing, or new, Faraday instance.
    # If a new connection is desired, #reset must be called.
    def connection
      if self.configuration[:endpoint].nil?
        raise ConfigurationError, "No endpoint set!"
      end

      opts = {
        :url => self.configuration[:endpoint] 
      }
      opts[:ssl] = {:verify => false} if !self.configuration[:ssl_verify]

      @connection ||= Faraday.new(opts) do |c|
        c.use Faraday::Request::UrlEncoded  
        c.use Faraday::Response::Logger
        c.use Faraday::Adapter::NetHttp
        c.use Splunker::FaradayMiddleware
      end
    end
  end
end
