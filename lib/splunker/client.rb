require 'splunker/configuration'
require 'splunker/auth'

module Splunker
  class Client
    include Configuration

    def initialize(options={})
      self.reset

      (Configuration::MUTABLE_IMPLEMENTED_OPTION_KEYS + Configuration::MUTABLE_OPTION_KEYS).each do |key|
        self.send "#{key}=", options[key] if options.include?(key)
      end
    end

    def method_missing(method,*args,&block)
      if self.request_handler.respond_to?(method)
        return self.request_handler.send(method,*args,&block)
      end
      super
    end
    
    def respond_to?(method)
      self.request_handler.respond_to?(method) || super
    end
  end
end
