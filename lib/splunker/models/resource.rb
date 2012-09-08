module Splunker
  module Models
    require 'cgi'

    class Resource 

      include Finders

      def self.service_path(path)
        @service_path = path
      end

      def self.client
        Splunker.client
      end

      protected

      # Basic path validation.  Does nothing useful atm. 
      def self.assemble_path(path_str)
        path_str.gsub(/\/+/,"/")
      end

      # Escapes a object ID for use in a URI
      def self.escape_object_id(id_str)
        CGI.escape(id_str)
      end
    end
  end
end
