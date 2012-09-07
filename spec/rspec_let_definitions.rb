module Splunker
  module RspecLetDefinitions
    def self.included(base)
      base.let(:client) {
        Splunker.client(
          :auth_mode => :http_auth,
          :endpoint  => "https://127.0.0.1",
          :username  => "tido",
          :password  => "12345",
          :app       => "search" 
        )
      }
    end
  end
end
