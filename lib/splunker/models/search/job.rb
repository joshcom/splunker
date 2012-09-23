module Splunker::Models
  module Search 
    class Job < Splunker::Models::Resource
      # http://docs.splunk.com/Documentation/Splunk/latest/RESTAPI/RESTsearch#search.2Fjobs.2F.7Bsearch_id.7D
      service_path "jobs"
    end
  end
end
