module Splunker::Models
  module Search
    class Jobs < Splunker::Models::Resource
      # http://docs.splunk.com/Documentation/Splunk/4.3.3/RESTAPI/RESTsearch#search.2Fjobs
      # Jobs are a data structure in themselves
      # Jobs have subresources for:
      # * scheduled search results
      def self.results(scheduled_search_id)
      end
    end
  end
end
