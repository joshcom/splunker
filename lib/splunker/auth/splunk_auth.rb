module Splunker
  module Auth
    class SplunkAuth
      include Splunker::Request

      attr_accessor :configuration

      def initialize(configuration)
        self.configuration = configuration
      end
    end
  end
end
