module Splunker
  module RspecLetDefinitions
    def self.included(base)
      base.let(:client) {
        Splunker.client(
          :endpoint => "https://127.0.0.1",
          :username => "tido",
          :password => "12345",
          :app      => "search" 
        )
      }
    end
  end
end
