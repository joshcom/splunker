require 'splunker/request'
require 'splunker/auth/splunk_auth'
Dir[File.dirname(__FILE__) + '/auth/*.rb'].each do |file| 
  next if file.match("splunk_auth")
  require file 
end

module Splunker
  module Auth
    def self.create(auth_type, configuration)
      if (obj = Splunker::Auth.const_get("#{auth_type}".split('_').collect(&:capitalize).join))
        obj.new(configuration)
      else
        raise ArgumentError, "Unknown auth type of #{auth_type}"
      end
    end
  end
end
