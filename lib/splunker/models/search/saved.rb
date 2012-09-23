module Splunker::Models
  module Search 
    class Saved < Splunker::Models::Resource
      # http://docs.splunk.com/Documentation/Splunk/4.3.4/RESTAPI/RESTsearch#saved.2Fsearches.2F.7Bname.7D
      service_path "saved/searches"

=begin Can these actions be standardized?
      def acknowledge; end
      def dispatch; end
      def history; end
      def scheduled_times; end
      def suppress; end
=end
    end
  end
end
