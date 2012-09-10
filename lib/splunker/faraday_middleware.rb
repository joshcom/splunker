require 'nokogiri'
module Splunker
  class FaradayMiddleware < Faraday::Response::Middleware
    def initialize(app)
      super(app)
    end

    def on_complete(env)
      env[:body] = Nokogiri::XML(env[:body])
      Splunker.logger.debug("Response Body: #{env[:body]}")
      Splunker::Errors.raise_error_for_status!(env[:status], env[:body])
      Splunker.logger.debug "Request successful!"
    end
  end
end
