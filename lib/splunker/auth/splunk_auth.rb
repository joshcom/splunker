module Splunker
  module Auth
    class SplunkAuth
      include Splunker::Request

      attr_accessor :client

      def initialize(client)
        self.client = client
      end

      def configuration
        self.client.configuration
      end

    end
  end
end
