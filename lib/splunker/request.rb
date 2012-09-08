require 'splunker/connection'

module Splunker
  module Request

    def authenticate; end

    def authenticated?
      true
    end

    def authenticate_connection(conn)
      conn
    end

    def get(resource, parameters={})
      request(:get, resource, parameters)
    end

    #def post(resource, body={})
    #  request(:post, resource, nil, body)
    #end

    ###
    # put/delete can come as needed.
    ###

    def request(method, resource, parameters={}, body={})
      authenticate unless authenticated?
      authenticate_connection(self.connection)
      self.connection.send(method, resource)
    end

    def self.included(base)
      base.send(:include, Splunker::Connection)
    end
  end
end
