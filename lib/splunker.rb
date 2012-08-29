require "splunker/version"
require "splunker/client"

module Splunker
  def self.client(options={})
    unless options.empty?
      Thread.current[:splunker_client] = Splunker::Client.new(options)
    end

    Thread.current[:splunker_client] 
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
