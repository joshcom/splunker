Dir[File.dirname(__FILE__) + '/auth/*.rb'].each {|file| require file }

module Splunker
  module Auth
    def self.create(auth_type)
      if (obj = Splunker::Auth.const_get("#{auth_type}".split('_').collect(&:capitalize).join))
        obj
      else
        raise ArgumentError, "Unknown auth type of #{auth_type}"
      end
    end
  end
end
