require 'logger'
require "splunker/version"
require "splunker/client"
require "splunker/errors"
require "splunker/models"

# The parent Splunker module can directly invoke any method invokable by the 
# client returned in Splunker.client, so long as Splunker.client has been
# called once with options to instantiate a new client.
#
# If using the helper models, you must first configure Splunker with
# Splunker.client({ :options => "..." }), as they all reference Splunker.client
# when they make requests.
module Splunker

  # Returns a reference to the current Splunk API client if no options are
  # supplied.  Otherwise, generates a new Splunker client.
  #
  # Parameters:
  # * options => See Splunker::Client's initialize method for details.
  # Returns an instance of Splunker::Client 
  def self.client(options={})
    unless options.empty?
      Thread.current[:splunker_client] = Splunker::Client.new(options)
    end

    Thread.current[:splunker_client] 
  end

  # A reference to the Splunker logger
  def self.logger
    if @logger.nil?
      @logger = Logger.new(STDOUT)
      @logger.level = Logger::INFO
    end 
    @logger
  end

  # Parameters:
  # * custom_logger => A custom logger to use instead of Logger
  def self.logger=(custom_logger)
    @logger = custom_logger
  end
  
  def self.method_missing(method,*args,&block)
    if self.client.respond_to?(method)
      return self.client.send(method,*args,&block)
    end
    super
  end
  
  def self.respond_to?(method)
    self.client.respond_to?(method) || super
  end
end
