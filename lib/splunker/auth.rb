require 'splunker/request'
require 'splunker/auth/splunk_auth'
Dir[File.dirname(__FILE__) + '/auth/*.rb'].each do |file| 
  next if file.match("splunk_auth")
  require file 
end

module Splunker
  module Auth
    # Factory to create a authenticated Request wrapper for a specified auth type.
    # Parameters:
    # * auth_type => A symbol representing the auth type to generate.  Should be a symbolized
    #                class name for an existing implementation. (e.g. :http_auth, :token_auth)
    # * client    => A reference to the Splunker client instance.
    # Returns an instance of the authenticated request wrapper noted by auth_type
    # Raises ArgumentError if auth_type is invalid
    def self.create(auth_type, client)
      if (obj = Splunker::Auth.const_get("#{auth_type}".split('_').collect(&:capitalize).join))
        obj.new(client)
      else
        raise ArgumentError, "Unknown auth type of #{auth_type}"
      end
    end
  end
end
