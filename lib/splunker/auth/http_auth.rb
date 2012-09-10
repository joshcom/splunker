module Splunker
  module Auth
    # Wraps Splunk API requests with basic authentication
    class HttpAuth < SplunkAuth
      def authenticate_connection(conn)
        return if self.configured?
        conn.basic_auth(configuration[:username],
                        configuration[:password])
        @configured = true
      end

      def configuration_valid?
        !configuration[:username].nil? &&
          !configuration[:password].nil?
      end

      def verify_configuration!
        unless configuration_valid?
          raise Splunker::Errors::ConfigurationError, 
            "HttpAuth requires both :username and :password configuration options be set"
        end
      end
    end
  end
end
