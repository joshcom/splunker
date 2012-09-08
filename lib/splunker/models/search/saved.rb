module Splunker
  module Models
    class Search::Saved < Resource
      # http://docs.splunk.com/Documentation/Splunk/4.3.3/RESTAPI/RESTsearch#search.2Fjobs
      service_path "saved/searches"
      # service_path
      # service_path/id

      # Dispatch these?
      def acknowledge; end
      def dispatch; end
      def history; end
      def scheduled_times; end
      def suppress; end
    end
  end
end
