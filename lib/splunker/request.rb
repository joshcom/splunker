require 'splunker/connection'

module Splunker
  # The Request module, to be used by classes that will make requests to
  # the Splunk API.
  #
  # Note that any class that mixes in the Request module will also mix in
  # Splunker::Connection automatically (see Splunker::Request.included)
  module Request
    require 'addressable/uri'

    # Authenticates the user (not the request) identified by
    # :username and :password in the configuration.
    def authenticate; end

    # true if #authenticate does _not_ need to be called.
    def authenticated?
      true
    end

    # Attaches credentials to the supplied Faraday connection object.
    def authenticate_connection(conn)
      conn
    end

    # HTTP GET helper method.
    # Parameters:
    # * resource   => The resource under configuration[:endpoint] to make the 
    #                 request
    # * parameters => GET parameters to supply with the request.
    # Returns Nokogiri:XML:Document object, parsed from the response body.
    # Raises an exception from Splunker::Errors in accordance with the status code.
    def get(resource, parameters={})
      request(:get, resource, parameters)
    end

    def post(resource, body={})
      request(:post, resource, nil, body)
    end

    ###
    # put/delete can come as needed.
    ###

    # HTTP request helper method.
    # Parameters:
    # * method     => A symbol representing the HTTP method (:get, :post, :put, :delete)
    # * resource   => The resource under configuration[:endpoint] to make the 
    #                 request
    # * parameters => GET parameters to supply with the request.
    # * body       => POST/PUT data
    # Returns Nokogiri:XML:Document object, parsed from the response body.
    # Raises an exception from Splunker::Errors in accordance with the status code.
    def request(method, resource, parameters={}, body={})
      authenticate unless authenticated?
      authenticate_connection(self.connection)
      final_resource = resource_builder(resource, parameters)
      self.connection.send(method, final_resource, body).body
    end

    # Returns a string representing the final resource path
    def resource_builder(resource, parameters={})
      u = Addressable::URI.new
      u.path = assemble_path("/servicesNS/#{configuration[:username]}/#{configuration[:app]}/#{resource}")
      unless parameters.nil? || parameters.empty?
        # Let's remap and cast everything to a string.
        # Addressable doesn't handle values like true well.
        final_parameters = {}
        parameters.map do |key, value|
          final_parameters[key] = "#{value}"
        end
        u.query_values = final_parameters 
      end
      u.to_s
    end

    def assemble_path(path_str)
      path_str.gsub(/\/+/,"/")
    end

    def self.included(base)
      base.send(:include, Splunker::Connection)
    end
  end
end
