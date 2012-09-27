module Splunker::Models
  module Search 
    class Job < Splunker::Models::Resource
      # http://docs.splunk.com/Documentation/Splunk/latest/RESTAPI/RESTsearch#search.2Fjobs.2F.7Bsearch_id.7D
      service_path "search/jobs"

      def results
        Results.find_as_subresource(Job.my_service_path, self.sid, "results")
      end
=begin BIG FAT TODO
search/jobs/{search_id}/export
search/jobs/{search_id}/control
search/jobs/{search_id}/events
search/jobs/{search_id}/results_preview
search/jobs/{search_id}/search.log
search/jobs/{search_id}/summary
search/jobs/{search_id}/timeline
=end
    end
  end
end
